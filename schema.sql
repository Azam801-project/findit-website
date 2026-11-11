-- Run this file in Supabase SQL Editor. PostgreSQL is the persistent source of truth.
create extension if not exists pgcrypto;
create table if not exists public.items (
 id uuid primary key default gen_random_uuid(),
 status text not null check (status in ('lost','found','returned')),
 category text not null,
 title text not null,
 description text not null,
 location text not null,
 event_date date not null,
 image_url text,
 contact_email text not null,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
create index if not exists items_status_idx on public.items(status);
create index if not exists items_category_idx on public.items(category);
create index if not exists items_created_at_idx on public.items(created_at desc);
create index if not exists items_search_idx on public.items using gin (to_tsvector('english', title || ' ' || description || ' ' || location));
-- API uses a server-only service-role key. Do not expose that key to the browser.
alter table public.items enable row level security;
-- No anon policies are intentionally added: public reads/writes go through validated server routes.
