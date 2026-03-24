# ⚡ DataFlow — Power Engineering Task Tracker

A Monday.com-style task and activity tracker built for Data Engineering teams. Single-file deployment, cloud-backed with Supabase, hosted free on Netlify.

![Status](https://img.shields.io/badge/status-active-brightgreen)
![Built with](https://img.shields.io/badge/built%20with-React%20%2B%20Supabase-6366f1)

---

## Features

- **📋 Table View** — Monday.com-style board with groups, inline status/priority/owner/date editing
- **🗂 Kanban View** — Status columns with colour-coded priority cards
- **📅 Timeline View** — Gantt chart showing tasks across a 14-week window
- **💬 Activity Log** — Per-task comment thread and automatic change history
- **👥 Team Management** — Assign owners with coloured avatars
- **🔍 Filter & Search** — Filter by status, priority, or free-text search
- **🔗 Shareable URL** — Bookmark a URL that connects to your database from any browser

---

## Quick Start

See [`SETUP_GUIDE.md`](./SETUP_GUIDE.md) for the full step-by-step instructions.

**tl;dr:**
1. Create a free [Supabase](https://supabase.com) project and run `schema.sql` in the SQL Editor
2. Copy your Project URL and anon key from Project Settings → API
3. Deploy `index.html` to [Netlify](https://netlify.com) (drag & drop or auto-deploy via this repo)
4. Open the app, enter your Supabase credentials, done

---

## Deployment

This repo is connected to Netlify for automatic deploys. Every push to `main` goes live within ~30 seconds.

| Branch | URL |
|--------|-----|
| `main` | Production (your Netlify URL) |

---

## Making Changes

All app logic lives in `index.html`. The structure inside the `<script>` block:

| Section | What it contains |
|---------|-----------------|
| `CONSTANTS` | Status/priority colours, group colour palette |
| `CONFIG` | localStorage + URL hash credential management |
| `API LAYER` | All Supabase database operations |
| `ATOMS` | Small reusable UI components (Avatar, StatusChip, etc.) |
| `SETUP SCREEN` | First-run Supabase connection flow |
| `TASK MODAL` | Full task detail view + activity log |
| `TABLE VIEW` | Main Monday.com-style board |
| `KANBAN VIEW` | Status column cards |
| `TIMELINE VIEW` | Gantt chart |
| `SIDEBAR` | Project navigation |
| `APP` | Top-level state, routing, data loading |

---

## Database Schema

Run `schema.sql` in your Supabase SQL Editor. Tables:

- `projects` — top-level containers (boards)
- `task_groups` — sections within a project (e.g. Sprint 1, Backlog)
- `tasks` — individual work items with status, priority, owner, dates
- `activities` — comments + automatic field-change history per task
- `team_members` — people available for owner assignment

---

## Changelog

See [`CHANGELOG.md`](./CHANGELOG.md)

---

## Stack

- **Frontend:** React 18 (CDN), Babel standalone, vanilla CSS
- **Database:** Supabase (PostgreSQL)
- **Hosting:** Netlify (static)
- **No build step required**
