// Connects Groove to your Supabase project for sync between devices.
// Leave both empty to run Groove on this device only.
// The publishable key is meant to live in a web page: the database rules in supabase-setup.sql
// keep everyone except you out of your records. Never put a secret key (sb_secret_...) here.
window.GROOVE_SUPABASE = {
  url: 'https://oigxevpbkrzaebrtqsxl.supabase.co',  // e.g. 'https://abcdefghijklmnop.supabase.co'
  key: 'sb_publishable_P0oT66egKm11VaZdLoMtIQ_oMjBM0mH  '   // e.g. 'sb_publishable_...'
};
