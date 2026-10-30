# Groove

A record collection organizer for vinyl and CDs: shelf order, cover art, tracklists, a wishlist, a listening log and barcode lookup. It runs as a single web page. Supabase keeps the collection in sync between your devices.

## Files

| File | What it is |
|---|---|
| `index.html` | The whole app |
| `config.js` | Your Supabase address and publishable key (empty means Groove only saves on the device you're using) |
| `supabase-setup.sql` | Creates the sync table and the rules that keep your data private |

---

## Setup: about 15 minutes

### 1. Create the Supabase project

1. Go to **supabase.com**, then **Start your project**. You can sign in with GitHub.
2. Click **New project**. Name it `groove`, choose a database password (save it somewhere), pick the region closest to you, then **Create new project**. It takes a minute or two to start.
3. In the left sidebar, open **SQL Editor**, then **New query**.
4. Open `supabase-setup.sql`, copy all of it, paste it into the editor and click **Run**. You should see *Success. No rows returned*.
5. Click **Connect** at the top of the project page, or go to **Settings → API Keys**. Copy:
   - the **Project URL**, like `https://abcdefghijklmnop.supabase.co`
   - the **Publishable key**, starting with `sb_publishable_`

   Never use the **secret** key (`sb_secret_…`) in Groove.

### 2. Add your keys to `config.js`

Open `config.js` in Notepad and fill in both values:

```js
window.GROOVE_SUPABASE = {
  url: 'https://abcdefghijklmnop.supabase.co',
  key: 'sb_publishable_xxxxxxxxxxxxxxxx'
};
```

The publishable key is designed to be public. The rules from `supabase-setup.sql` only ever let you see your own records.

### 3. Put Groove on GitHub Pages

1. Go to **github.com** and sign in or create an account.
2. Click **+** (top right), then **New repository**. Name it `groove`, set it to **Public** (free GitHub Pages needs a public repository), then **Create repository**.
3. On the new repository page, click **uploading an existing file**. Drag in `index.html`, `config.js`, `supabase-setup.sql` and `README.md`, then **Commit changes**.
4. Open the repository's **Settings**, then **Pages**. Under *Build and deployment*, set **Source** to **Deploy from a branch** and **Branch** to **main** with **/ (root)**, then **Save**.
5. After a minute or two the page shows your address: **`https://YOUR-USERNAME.github.io/groove/`**.

Only the app is in the repository, none of your records. Your collection lives in Supabase.

### 4. Let Supabase send you back to Groove after sign-in

1. In Supabase, open **Authentication → URL Configuration**.
2. Set **Site URL** to your Groove address, e.g. `https://YOUR-USERNAME.github.io/groove/`.
3. Under **Redirect URLs**, click **Add URL**, paste the same address, then save.

### 5. Sign in and load your collection

1. Open your Groove address, then **Settings → Sync between devices**. Enter your email and click **Email me a sign-in link**.
2. Open the email **on the same device** and click the link. Groove opens signed in, and the dot on **Settings** turns green.
3. Load your records with **Settings → Import a collection**:
   - If you used Groove from the file on your computer (Tune-up fixes, plays, wishlist), first open that copy and use **Settings → Export backup**, then import that file here.
   - Otherwise import `groove-collection.json`.

   It uploads to Supabase automatically.
4. On your phone, open the same address and sign in with the same email. Your collection appears. In the browser menu, choose **Add to Home screen** to open it like an app.

### 6. Lock the door (recommended)

When you're signed in on your devices, go to **Authentication → Sign In / Providers** in Supabase and turn off **Allow new users to sign up**. Nobody else can then create an account on your project, and you can still sign in on new devices with your existing email.

---

## Good to know

- **Sign-in emails are limited.** Supabase's built-in email sender allows about 2 emails an hour, and one link per minute. You stay signed in, so you only need a link once per device.
- **Offline works.** Groove saves on the device first and syncs when you're back online. If you change the same record on two devices before they sync, the later change wins.
- **Updating Groove later:** in the GitHub repository, click **Add file → Upload files** and drop in the new `index.html`. Your records are unaffected.
- **Camera scanning** works on the GitHub Pages address because it's HTTPS. Your browser asks for camera permission the first time.
