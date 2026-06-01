# Data layer

Organized for the **agent's tool path**, not the human UI. Everything here is
markdown or CSV — easy to search, diff, edit, and upload back.

## Source of truth
The *live* source of truth is **Google Drive + Box** (durable, survives the
ephemeral cloud runtime). This folder holds agent-readable mirrors and the one
dataset that's better kept flat and in-repo: contacts.

## Files
- **`contacts.csv`** — every person I know: email, phone, WhatsApp/Telegram
  handles, LinkedIn, category, location, notes. The single highest-leverage
  asset in the stack. Keep it synced with the Contacts MCP server (see the
  `contacts` skill). The committed file is a template — replace the example row.
- **`docs/`** — markdown mirrors of important Drive/Box docs (car, family,
  personal admin). Edit here, then push the change back to Drive/Box.

## Rules
- Markdown + CSV only. No binary blobs that the agent can't diff.
- `contacts.csv` columns are fixed: `name,email,phone,whatsapp,telegram,linkedin,category,location,notes`.
- Don't commit secrets, full financials, or government IDs. Those live in Drive/Box
  with proper access control, fetched per-task.
