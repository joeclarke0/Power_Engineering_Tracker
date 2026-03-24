-- ============================================================
-- DataFlow - Engineering Task Tracker
-- Supabase SQL Schema
-- Run this in your Supabase project's SQL Editor
-- ============================================================

-- Projects (top-level containers, like boards in Monday.com)
CREATE TABLE IF NOT EXISTS public.projects (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name        TEXT NOT NULL,
  color       TEXT DEFAULT '#3b82f6',
  description TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Task groups (sections within a project, e.g. "Sprint 1", "Backlog", "In Flight")
CREATE TABLE IF NOT EXISTS public.task_groups (
  id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  project_id   UUID REFERENCES public.projects(id) ON DELETE CASCADE,
  name         TEXT NOT NULL,
  color        TEXT DEFAULT '#3b82f6',
  position     INTEGER DEFAULT 0,
  is_collapsed BOOLEAN DEFAULT FALSE,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- Tasks (individual work items)
CREATE TABLE IF NOT EXISTS public.tasks (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  group_id    UUID REFERENCES public.task_groups(id) ON DELETE CASCADE,
  project_id  UUID REFERENCES public.projects(id) ON DELETE CASCADE,
  name        TEXT NOT NULL,
  status      TEXT DEFAULT 'Not Started'
              CHECK (status IN ('Not Started','In Progress','Review','Done','Blocked')),
  priority    TEXT DEFAULT 'Medium'
              CHECK (priority IN ('Critical','High','Medium','Low')),
  owner       TEXT,
  due_date    DATE,
  start_date  DATE,
  description TEXT,
  position    INTEGER DEFAULT 0,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Activity log (comments + automatic field-change history)
CREATE TABLE IF NOT EXISTS public.activities (
  id         UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  task_id    UUID REFERENCES public.tasks(id) ON DELETE CASCADE,
  type       TEXT NOT NULL
             CHECK (type IN ('comment','status_change','created','field_change')),
  content    TEXT NOT NULL,
  old_value  TEXT,
  new_value  TEXT,
  author     TEXT DEFAULT 'You',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Team members (used for owner assignment and avatars)
CREATE TABLE IF NOT EXISTS public.team_members (
  id         UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name       TEXT NOT NULL,
  email      TEXT,
  role       TEXT,
  color      TEXT DEFAULT '#6366f1',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- Row Level Security
-- For a personal / team tool, we allow all operations via
-- the anon key. Enable this block if you want open access.
-- ============================================================
ALTER TABLE public.projects     ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.task_groups  ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tasks        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.activities   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.team_members ENABLE ROW LEVEL SECURITY;

-- Allow all operations for anonymous users (anon key in the browser)
CREATE POLICY "Allow all for anon" ON public.projects     FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON public.task_groups  FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON public.tasks        FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON public.activities   FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON public.team_members FOR ALL USING (true) WITH CHECK (true);

-- ============================================================
-- Sample Seed Data (optional — delete if you want a clean start)
-- ============================================================

-- Sample team members
INSERT INTO public.team_members (name, role, color) VALUES
  ('Joe',   'Engineering Manager',    '#6366f1'),
  ('Alice',  'Senior Data Engineer',  '#10b981'),
  ('Bob',    'Data Engineer',         '#f97316'),
  ('Carol',  'Analytics Engineer',    '#ec4899'),
  ('Dave',   'Data Platform Engineer','#06b6d4')
ON CONFLICT DO NOTHING;

-- Sample project
INSERT INTO public.projects (id, name, color) VALUES
  ('00000000-0000-0000-0000-000000000001', 'Data Platform', '#6366f1')
ON CONFLICT DO NOTHING;

-- Sample groups
INSERT INTO public.task_groups (id, project_id, name, color, position) VALUES
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Sprint 1 — Active',  '#10b981', 0),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'Backlog',             '#6366f1', 1),
  ('10000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', 'Completed',           '#9ca3af', 2)
ON CONFLICT DO NOTHING;

-- Sample tasks
INSERT INTO public.tasks (group_id, project_id, name, status, priority, owner, due_date, start_date, position) VALUES
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Set up dbt project structure',          'Done',        'High',     'Alice', '2026-03-15', '2026-03-10', 0),
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Build ingestion pipeline for Salesforce','In Progress',  'Critical', 'Bob',   '2026-03-28', '2026-03-20', 1),
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Write data quality tests for orders',    'In Progress',  'High',     'Carol', '2026-03-30', '2026-03-22', 2),
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Performance review — Snowflake queries', 'Review',       'Medium',   'Dave',  '2026-04-02', '2026-03-25', 3),
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Resolve data lineage blocker',           'Blocked',      'Critical', 'Bob',   '2026-03-27', '2026-03-24', 4),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'Implement CDC for transactional DB',      'Not Started',  'High',     'Alice', '2026-04-10', '2026-04-01', 0),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'Add PII masking to raw layer',            'Not Started',  'High',     NULL,    '2026-04-15', '2026-04-07', 1),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'Dashboard for pipeline run history',      'Not Started',  'Medium',   'Carol', '2026-04-20', '2026-04-14', 2),
  ('10000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', 'Migrate legacy ETL scripts to Airflow',   'Done',         'High',     'Dave',  '2026-03-10', '2026-02-20', 0),
  ('10000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', 'Document data dictionary',               'Done',         'Medium',   'Carol', '2026-03-05', '2026-02-28', 1)
ON CONFLICT DO NOTHING;
