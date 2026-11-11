import { neon } from "@neondatabase/serverless";

export function db() {
  const url = process.env.DATABASE_URL;
  if (!url) throw new Error("Neon DATABASE_URL is not configured. Check your .env.local file.");
  return neon(url);
}
