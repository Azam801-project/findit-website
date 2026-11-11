import { NextResponse } from "next/server";
import { db } from "@/lib/db";

export async function POST(req: Request) {
  try {
    const b = await req.json();
    const required = ["status", "category", "title", "description", "location", "event_date", "contact_email"];
    for (const k of required) if (!b[k]) return NextResponse.json({ error: `${k} is required` }, { status: 400 });
    if (!["lost", "found"].includes(b.status)) return NextResponse.json({ error: "Invalid report type" }, { status: 400 });
    const sql = db();
    const rows = await sql`INSERT INTO items (status, category, title, description, location, event_date, image_url, contact_email)
      VALUES (${b.status}, ${b.category}, ${b.title.trim()}, ${b.description.trim()}, ${b.location.trim()}, ${b.event_date}, ${b.image_url || null}, ${b.contact_email.toLowerCase().trim()})
      RETURNING id, title, status, category, description, location, event_date, image_url, contact_email, created_at`;
    return NextResponse.json({ item: rows[0] }, { status: 201 });
  } catch (e: any) {
    return NextResponse.json({ error: e.message || "Unable to create report" }, { status: 500 });
  }
}

export async function GET() {
  try {
    const items = await db()`SELECT id, title, category, description, location, status, created_at, image_url FROM items ORDER BY created_at DESC LIMIT 100`;
    return NextResponse.json({ items });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
