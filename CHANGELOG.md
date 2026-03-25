# Changelog

All notable changes to DataFlow are documented here.
Format: `## [version] — YYYY-MM-DD` followed by what changed.

---

## [1.0.5] — 2026-03-25

### Branding

- **Custom SVG logo** — lightning bolt removed; replaced with a bespoke "J" data-pipeline mark: a white source node at the top, a subtle mid-flow dot, and a green destination node at the end of the hook (representing data engineering + task completion). Renders crisply at all sizes via scalable viewBox.

---

## [1.0.4] — 2026-03-25

### Branding & theme

- **Renamed to Joe.com** — browser tab, setup screen, sidebar, and footer all updated
- **Replaced purple brand colour** — all indigo/violet UI chrome (`#6366f1`, `#4f46e5`, `#8b5cf6`) replaced with a dark charcoal/near-black palette (`#18181b`, `#27272a`, `#3f3f46`)
- Setup screen background changed from deep purple gradient to near-black
- Sidebar active project highlight, New Project button, focus rings and interactive accents all updated to dark greys
- Status, priority, and group/member colours are unchanged

---

## [1.0.3] — 2026-03-25

### New features

- **Edit team members** — hover any member row to reveal a ✏️ button; click to edit name and role inline; Save/Cancel buttons or Enter/Escape to confirm
- **Remove team members** — hover any member row to reveal a × button; click with confirmation prompt to remove
- Added `updateMember` and `deleteMember` to the API layer

---

## [1.0.2] — 2026-03-25

### New features

- **Inline due date editing** — click the Due Date cell in any table row to open a native date picker; saves on pick/Enter, cancels on Escape; empty pick clears the date
- **Drag-and-drop task reordering** — a grip handle (⠿) appears on hover; drag a task to reorder it within its group or move it to another group; new order is persisted to Supabase immediately
- Drop target highlighted with an indigo line so you always know where the task will land

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
