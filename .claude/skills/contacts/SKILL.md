---
name: contacts
description: Look up, enrich, and dedupe people across the Contacts MCP server and data/contacts.csv. The CSV is the durable mirror; keep the two in sync. Use this for any email or phone lookup before searching email or the web.
---

# contacts

The contacts dataset is the highest-leverage piece of the stack — it turns "find
her email" into a lookup. Keep it clean and in sync.

## Lookups (read)
1. Search `data/contacts.csv` first (fast, offline, in-repo).
2. Fall back to the Contacts MCP `searchContacts` / `getEmails`.
3. Only then search Gmail/web — and when you find a new email/phone, **offer to
   add it** (ask-tier) to both the CSV and the Contacts server.

## Enrichment / dedupe (mutate — ask first)
- Use `find_duplicates` to surface dupes; propose merges, never auto-merge.
- When adding/updating a person, write to **both** the Contacts server and the
  CSV so they stay consistent. Show the diff before writing.
- Standard CSV columns (see `data/contacts.csv`):
  `name,email,phone,whatsapp,telegram,linkedin,category,location,notes`

## Rules
- Never expose someone's private contact details unless the task needs them.
- `category` drives triage elsewhere (family / close / work / vendor) — keep it set.
- If the CSV and the Contacts server disagree, surface the conflict; don't guess.
