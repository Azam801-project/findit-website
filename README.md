# FindIt – Lost & Found Website (Neon PostgreSQL)

A responsive Next.js lost-and-found community website with a dark dashboard, report submission, searchable listings, item detail pages and basic rule-based matching. Reports are stored persistently in a Neon PostgreSQL database.

## Requirements
- Node.js 20 or later
- A Neon account and PostgreSQL project

## Setup on Windows
1. Extract this folder. Open Command Prompt in the project folder.
2. Install dependencies: `npm install`
3. In Neon Console, open your project and select **Connect**. Copy the connection string for Node.js. Keep it private.
4. Create a file named `.env.local` in the project root (same folder as `package.json`) with this line:
   `DATABASE_URL="paste_your_full_neon_connection_string_here"`
5. In Neon SQL Editor, open `neon-schema.sql`, copy all its SQL, paste it into the editor and click **Run**.
6. Start the website: `npm run dev`
7. Open http://localhost:3000

## Important
- Do not share `.env.local` or your Neon connection string. Never commit it to GitHub.
- The smart matching page uses basic keyword/category/location scoring; it is not a trained AI model.
- This is a school-project starter. Before public deployment, add authentication, report ownership/moderation, rate limiting and privacy controls.
