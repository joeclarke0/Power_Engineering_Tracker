# Changelog

All notable changes to DataFlow are documented here.
Format: `## [version] — YYYY-MM-DD` followed by what changed.

---

## [1.0.1] — 2026-03-24

### Bug fixes

- Fixed status, priority, and owner dropdowns closing immediately without registering a selection — dropdowns now render inline (position: fixed) instead of via React Portal, so the outside-click detection works correctly
- Added React ErrorBoundary so render errors show a helpful message with a reload button instead of a blank white page

---

## [1.0.0] — 2026-03-24

### Initial release

- Table view with project groups, task rows, inline editing for status, priority, owner, and due date
- Kanban view with colour-coded status columns
- Timeline / Gantt view with 14-week window and today marker
- Task modal with full field editing, description, and activity log
- Comment system with per-task activity feed and automatic change history
- Team member management with coloured avatars
- Search and filter bar (by task name, status, priority)
- Supabase backend with Row Level Security
- First-run setup screen with credential storage in localStorage
- Shareable bookmark URL encoding credentials in URL hash
- Sample seed data: Data Platform project with 5 team members and 10 tasks
