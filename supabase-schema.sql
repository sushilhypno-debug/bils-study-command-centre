-- BILS Study Command Centre cloud progress
-- Run this in Supabase SQL Editor after creating a project.
create table if not exists public.student_progress (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.student_progress enable row level security;

drop policy if exists "Users can read own progress" on public.student_progress;
create policy "Users can read own progress"
  on public.student_progress for select
  using (auth.uid() = user_id);

drop policy if exists "Users can insert own progress" on public.student_progress;
create policy "Users can insert own progress"
  on public.student_progress for insert
  with check (auth.uid() = user_id);

drop policy if exists "Users can update own progress" on public.student_progress;
create policy "Users can update own progress"
  on public.student_progress for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create or replace function public.set_student_progress_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end; $$;

drop trigger if exists student_progress_updated_at on public.student_progress;
create trigger student_progress_updated_at
before update on public.student_progress
for each row execute function public.set_student_progress_updated_at();
