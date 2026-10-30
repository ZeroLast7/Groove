-- Groove: sync storage for one person's collection.
-- Paste this whole file into Supabase → SQL Editor → New query, then press Run.
-- Safe to run more than once.

-- One row per record, wishlist item or settings block. `data` holds the item exactly as Groove stores it.
create table if not exists public.groove_items (
  user_id    uuid        not null default auth.uid() references auth.users (id) on delete cascade,
  kind       text        not null check (kind in ('record', 'wish', 'settings')),
  id         text        not null,
  data       jsonb       not null default '{}'::jsonb,
  deleted    boolean     not null default false,
  updated_at timestamptz not null default now(),
  primary key (user_id, kind, id)
);

create index if not exists groove_items_user_updated on public.groove_items (user_id, updated_at);

-- The server stamps every change, so devices can ask "what changed since I last looked?"
create or replace function public.groove_touch() returns trigger
language plpgsql as $$
begin
  new.updated_at := now();
  return new;
end $$;

drop trigger if exists groove_items_touch on public.groove_items;
create trigger groove_items_touch
  before insert or update on public.groove_items
  for each row execute function public.groove_touch();

-- Lock it down: a signed-in person can only ever see and change their own rows.
alter table public.groove_items enable row level security;

drop policy if exists "groove: read own"   on public.groove_items;
drop policy if exists "groove: add own"    on public.groove_items;
drop policy if exists "groove: change own" on public.groove_items;
drop policy if exists "groove: remove own" on public.groove_items;

create policy "groove: read own"   on public.groove_items for select to authenticated using (user_id = auth.uid());
create policy "groove: add own"    on public.groove_items for insert to authenticated with check (user_id = auth.uid());
create policy "groove: change own" on public.groove_items for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "groove: remove own" on public.groove_items for delete to authenticated using (user_id = auth.uid());

-- Signed-out visitors get nothing at all.
revoke all on public.groove_items from anon;
grant select, insert, update, delete on public.groove_items to authenticated;
