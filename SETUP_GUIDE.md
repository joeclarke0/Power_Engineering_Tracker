# DataFlow — Engineering Task Tracker
## Setup & Deployment Guide

---

## What You're Getting

A fully functional task & activity tracker built for data engineering teams, with:

- **Table View** — Monday.com-style board with grouped tasks, inline status/priority/owner/date editing
- **Kanban View** — drag-free status columns with colour-coded cards
- **Timeline View** — Gantt-style chart showing tasks by date range
- **Task Modal** — full task details with a live activity log and comments
- **Cloud database** — all data stored in your personal Supabase project, accessible from any device

---

## Step 1 — Create a Supabase Project (Free)

1. Go to **[supabase.com](https://supabase.com)** and sign up for a free account
2. Click **"New Project"**, choose a name like `dataflow`, pick a region close to you, set a database password (keep it safe), and click **Create**
3. Wait about 60 seconds for your project to be ready

---

## Step 2 — Apply the Database Schema

1. In your Supabase project, click **"SQL Editor"** in the left sidebar
2. Click **"New query"**
3. Open the `schema.sql` file from this folder and paste the entire contents into the editor
4. Click **"Run"**
5. You should see a success message — this creates all the tables and adds sample data so you can see it working right away

---

## Step 3 — Get Your API Credentials

1. In your Supabase project, click **"Project Settings"** (gear icon) → **"API"**
2. Copy:
   - **Project URL** — looks like `https://abcdefghij.supabase.co`
   - **anon / public key** — a long JWT string starting with `eyJ…`

> The anon key is safe to use in the browser. It's designed to be public and is protected by Row Level Security policies in the schema.

---

## Step 4 — Deploy to Netlify (Free)

### Option A: Drag & Drop (easiest, ~2 minutes)

1. Go to **[netlify.com](https://netlify.com)** and sign up for a free account
2. From your dashboard, find the "Deploy manually" section or drag your **`index.html`** file directly onto the Netlify deploy area
3. Netlify gives you a live URL like `https://cheerful-cupcake-abc123.netlify.app`

That's it — your app is live!

### Option B: Custom Domain

After deploying on Netlify you can set a custom domain (e.g. `tracker.yourcompany.com`) in Site Settings → Domain Management.

---

## Step 5 — First-time Configuration in the App

1. Visit your new Netlify URL
2. The app shows a **setup screen** — paste in your Supabase Project URL and anon key
3. Click **"Connect to Supabase"**
4. If successful, you'll see your board loaded with sample data

---

## Step 6 — Bookmark Your Personalised URL

Once connected, click **"🔗 Share / Bookmark link"** in the bottom of the sidebar.

This generates a URL with your credentials encoded in the hash (never sent to any server). **Bookmark this URL** — opening it in any browser will connect directly to your Supabase database without needing to re-enter credentials.

> Keep this URL private — anyone with it can access your data.

---

## Daily Use

| Action | How |
|---|---|
| Add a project | Sidebar → "+ New Project" |
| Add a group | Table view → "+ Add Group" button at bottom |
| Add a task | Click "+ Add task" at the bottom of any group |
| Edit a task | Click any cell inline, or click the task name to open the modal |
| Change status | Click the coloured status pill in any row |
| Assign owner | Click the owner cell → search team members |
| Add a comment | Open task modal → type in the activity box |
| Filter tasks | Use the search bar and dropdowns in the filter bar |
| Switch views | Table / Kanban / Timeline tabs in the top right |
| Manage team | Click "👥 Team" button in the top bar |

---

## Troubleshooting

**"Could not connect" on setup**
- Double-check your Project URL (must start with `https://`) and anon key
- Make sure you ran `schema.sql` — the app checks for the `projects` table on connection
- In Supabase, go to Authentication → Policies and confirm RLS policies were created

**Tasks not showing after adding**
- Click the ↻ refresh button in the top bar
- Check your browser console for errors (F12 → Console)

**Timeline view is empty**
- Tasks only appear in Timeline if they have a Start Date or Due Date set
- Open a task and add dates via the task modal

---

## Updating the App

Since everything is a single `index.html` file, updates are simple:
- Replace the `index.html` on Netlify (drag the new file to the deploy area)
- Your Supabase data is completely separate and unaffected

---

## Security Notes

- The Supabase anon key is intentionally public (it's rate-limited and protected by RLS)
- Your data is protected by the Row Level Security policies in `schema.sql`
- For a team environment, consider adding Supabase Auth to restrict access by user
- Never share your **service_role** key (only the **anon** key is used here)

---

*Built with React, Supabase, and hosted on Netlify — all free tiers.*
