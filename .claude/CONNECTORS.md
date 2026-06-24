# Connectors — capability map & command patterns

The MCP servers in my environment have opaque UUID names. This file maps each to
its real capability so skills and CLAUDE.md can refer to them by purpose. Tool
names are stable even when server IDs rotate — match on the **tool suffix**.

## MCP servers (live)

| Capability | Server ID (current) | Representative tools |
|---|---|---|
| Gmail | `90b8e497-…` | `search_threads`, `get_thread`, `create_draft`, `list_drafts`, `label_thread`, `list_labels` |
| Google Drive | `a9716f00-…` | `search_files`, `read_file_content`, `download_file_content`, `create_file`, `get_file_metadata` |
| Box | `8f317de4-…` | `search_files_keyword`, `get_file_content`, `upload_file`, `upload_file_version`, metadata templates, `who_am_i` |
| Calendar | `6ec838fa-…` | `list_calendars`, `list_events`, `get_event`, `create_event`, `update_event`, `delete_event`, `suggest_time` |
| Contacts/Notes/Reminders | `71bf22c7-…` | `searchContacts`, `getContact`, `getEmails`, `updateContact`, `merge_contacts`, `find_duplicates`, `createNote`, reminders |
| Zoom | `ea30f9f6-…` | `recordings_list`, `search_meetings`, `get_recording_resource`, `get_file_content` |
| Canva | `37f82d63-…` | `generate-design`, `export-design`, `search-designs` |
| Gamma | `78b66683-…` | `generate`, `generate_from_template`, `export` |
| GitHub | `github` | PRs, issues, file ops |

> **Gmail is draft-only by design** — there is no `send` tool. The agent prepares
> a draft; I send it from Gmail. This is the approval gate baked into the surface.

## Local CLI bridges (macOS only — not in cloud sessions)

Install via `scripts/setup.sh`. These cover the surfaces with no MCP server.
Prefer them over browser automation, but they rank below the MCP servers above.

```bash
# WhatsApp (wacli — whatsmeow bridge, JSON output)
wacli chats list --query "Friend Name" --json
wacli messages list --chat <jid> --limit 20 --json
wacli send text --to <jid> --message "Done"            # ask-tier: confirm first

# Telegram (MTProto / Telethon CLI) — same pattern
tgcli chats list --query "Name" --json
tgcli messages list --chat <id> --limit 20 --json
tgcli send --to <id> --message "..."                   # ask-tier

# iMessage / SMS (imsg — reads chat.db, needs Full Disk Access)
imsg chats list --json
imsg messages list --chat <handle> --limit 20 --json
imsg send --to <handle> --message "..."                # ask-tier
```

## Browser automation (last resort, for portals with no API)
Use a Playwright/Browser-Use controller for FasTrak, insurance, DMV, parking,
shopping portals. Always `ask` before submitting any form. Screenshot the result.
