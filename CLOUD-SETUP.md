# Cloud Save Setup

The app currently stores progress locally in the browser. This file prepares the project for secure cloud saving with Supabase.

## 1. Create a Supabase project

Create a new project at https://supabase.com/.

## 2. Run the database schema

Open **SQL Editor** in Supabase and run `supabase-schema.sql` from this repository.

## 3. Get the public project settings

Open **Project Settings → API** and note:
- Project URL
- Publishable/anon key

Never put a `service_role` key into this website.

## 4. Connect the website

The next app update will use the Project URL and public key to:
- sign the student in,
- load her progress,
- save progress automatically,
- keep the same progress when she changes device.

The database policy restricts each signed-in user to their own progress row.

## Important

Do not commit passwords, service-role keys, payment credentials, or other secrets to this public GitHub repository.
