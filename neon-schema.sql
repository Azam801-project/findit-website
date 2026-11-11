-- Run this in the Neon SQL Editor to create FindIt's persistent PostgreSQL table.
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE TABLE IF NOT EXISTS public.items (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
 status TEXT NOT NULL CHECK (status IN ('lost','found','returned')),
 category TEXT NOT NULL,
 title TEXT NOT NULL,
 description TEXT NOT NULL,
 location TEXT NOT NULL,
 event_date DATE NOT NULL,
 image_url TEXT,
 contact_email TEXT NOT NULL,
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS items_status_idx ON public.items(status);
CREATE INDEX IF NOT EXISTS items_category_idx ON public.items(category);
CREATE INDEX IF NOT EXISTS items_created_at_idx ON public.items(created_at DESC);
