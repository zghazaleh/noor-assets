# noor-assets — A Personal Agent Stack on Claude

This repo is the **operating brain** for a personal agent that runs my life admin —
email, messages, files, calendar, contacts — across the tools I already use.

It is a Claude-native adaptation of Nicolas Bustamante's "Codex personal agent
stack." The philosophy is identical:

> **Tools + Data + Skills + Approval gates + Continuous feedback.**
> The agent doesn't *answer questions*. It *operates across my tools* to finish
> small real-world jobs, and asks for approval at the moments that matter.

**New here? Read [`USAGE.md`](./USAGE.md)** — the human operating guide (what to
say, what comes back, when it stops to ask). This README is the architecture;
`USAGE.md` is the manual; `CLAUDE.md` is the agent's own rulebook.

The model and harness are different (Claude Code instead of Codex), and that
changes the *mechanics* in ways that are actually advantages — see below.

---

## 1. Why this is a Claude stack, not a clone of the Codex one

Nicolas hand-rolled CLIs (`gogcli`, `wacli`, `imsg`) because Codex needed a flat
command surface. Claude Code already speaks **MCP**, so most of those connectors
exist as first-class tool servers. The result is *less* glue code, not more.

| Nicolas (Codex / macOS) | This stack (Claude Code) |
|---|---|
| `gogcli` for Gmail/Drive/Calendar | Native **MCP servers**: Gmail, Google Drive, Calendar, Contacts |
| `AGENTS.md` | **`CLAUDE.md`** (auto-loaded operating rules) |
| Skills = markdown in folders | **`.claude/skills/*/SKILL.md`** (same idea, native invocation via `/skill`) |
| Approval = manual "show me first" prompts | **Permission tiers in `.claude/settings.json`** (`allow` / `ask` / `deny`) — enforced by the harness, not by me remembering |
| "Improve the skill after each mistake" | Same, plus **hooks** for automation the model can't be trusted to do every time |
| Always-on Mac runs the bridges | **Claude Code on the web**: ephemeral cloud container → Drive/Box *must* be the source of truth (see §5) |

The tool-surface hierarchy is unchanged, just re-labelled for Claude:

```
MCP server / API  >  CLI  >  local file  >  browser automation  >  screen automation
```

A `mcp__gmail__search_threads` call the model can inspect, retry, and reason about
beats clicking around gmail.com every time.

---

## 2. What's already wired (my actual connectors)

These MCP servers are live in my Claude environment today. They *are* the data
layer — there is nothing to install for the core stack.

| Server | Used for | Key tools |
|---|---|---|
| **Gmail** | reading/triage/drafting | `search_threads`, `get_thread`, `create_draft`, `label_thread` |
| **Google Drive** | source of truth (docs) | `search_files`, `read_file_content`, `create_file`, `download_file_content` |
| **Box** | source of truth (files/PDFs) | `search_files_keyword`, `get_file_content`, `upload_file`, metadata templates |
| **Calendar** | scheduling | `list_events`, `create_event`, `suggest_time` |
| **Contacts/Notes/Reminders** | the contacts CSV's live counterpart | `searchContacts`, `getEmails`, `merge_contacts`, `createNote`, reminders |
| **Zoom** | meeting recall | `recordings_list`, `search_meetings`, transcript fetch |
| **Canva / Gamma** | decks & one-pagers | `generate`, `export-design` |
| **GitHub** | this repo | PRs, issues, file ops |

> **Nice structural safety property:** the Gmail connector has *no send tool* —
> only `create_draft`. The agent physically cannot send an email. It drafts; I
> hit send in Gmail. The "draft before sending" rule Nicolas enforces by
> discipline is enforced here by the tool surface.

### Gaps to fill (the messaging surfaces I picked)

WhatsApp, Telegram and iMessage have no MCP server here. Because I run the agent
from **macOS**, I bridge them as local CLIs, exactly like Nicolas:

- **WhatsApp** → [`wacli`](https://github.com/) (whatsmeow bridge, `--json` output)
- **Telegram** → MTProto connector / Telethon CLI
- **iMessage / SMS** → `imsg` (reads `chat.db`, needs Full Disk Access)

`scripts/setup.sh` installs these and `CONNECTORS.md` documents the command
patterns. They sit *below* the MCP servers in the hierarchy but above browser
automation.

---

## 3. The data layer — legible, not elegant

Same principle Nicolas lives by: **organize knowledge for the agent's tool path,
not the human UI.** Markdown + CSV. Stable file IDs. Things the agent can search,
download, diff, edit, and upload back.

```
DATA LAYER
==========
Google Drive / Box   personal docs, car docs, family docs, PDFs, exported Notion  (markdown + csv)
Contacts server      live contacts — searchable, dedupable
data/contacts.csv    flat mirror of contacts (the single best investment)  ← in this repo
data/docs/*.md       agent-readable copies of the important docs
memory/preferences.md  my taste, encoded once so I stop being the prompt
```

`data/contacts.csv` is the "much more valuable than it looks" spreadsheet —
phone, email, LinkedIn, category, location, notes for everyone I know. It's what
turns "find her email" into a lookup instead of a hunt across five apps.

---

## 4. Skills — habits, not architecture

A skill is a small operating manual: how to do a recurring job *the way I like
it.* Scaffolded in `.claude/skills/`, invoked with `/inbox-zero` etc.

| Skill | Job-to-be-done |
|---|---|
| **`what-did-i-miss`** | The killer workflow. Scan Gmail + WhatsApp + Telegram + Calendar + recent Drive/Box changes → who needs a reply, what's urgent, what's stale, what should become an event. First-pass triage; judgment stays mine. |
| **`inbox-zero`** | Classify inbox → archive vs needs-review, quote substance, draft replies, **wait for approval**, preserve all cc, sign as me, archive only after I send. |
| **`contacts`** | Look up / dedupe / enrich contacts across the Contacts server and `contacts.csv`; keep them in sync. |
| **`intro-broker`** | The WhatsApp→email intro workflow: read the thread, find the email, research the company on the web, draft the intro with links, draft → I send → confirm back on WhatsApp. |
| **`personal-admin`** | The "license plate" pattern: update a doc in Drive/Box (preserving existing fields), then propagate the change to web portals via browser automation. |
| **`daily-sweep`** | `what-did-i-miss` on a timer. Run via `/loop` so triage happens on its own; diffs against the last sweep, stays quiet when nothing's new, never mutates on a scheduled run. |

**The feedback loop is the product:**

```
tool fails once          → fix the tool / add a guardrail in CLAUDE.md
agent misjudges          → tighten the SKILL.md
agent forgets a taste    → write it into memory/preferences.md
workflow repeats         → the agent gets quietly better
```

---

## 5. Approval gates (the part that makes it non-terrifying)

Trust is tiered, and in this stack the tiers are **enforced by the harness** via
`.claude/settings.json`, not by my vigilance:

| Tier | Examples | Setting |
|---|---|---|
| Read-only scan | search/read Gmail, Drive, Box, Calendar, Contacts | `allow` |
| Draft / prepare | `create_draft`, write a local file, draft a calendar event | `allow` (drafts are safe) |
| Mutating action | `create_event`, `upload_file`, `updateContact`, send WhatsApp/Telegram | `ask` |
| Destructive / outward | delete events/files, send to many people, payments, account settings | `ask` + extra confirmation in the relevant skill |

See `.claude/settings.json`. Low-stakes one-liners ("tell my wife I'm running
late") I can run loosely; an intro, an investor email, anything with social
nuance gets drafted first.

---

## 6. Running it from the cloud (Claude Code on the web)

Because web sessions run in an **ephemeral container** (cloned fresh, reclaimed
after inactivity), two rules follow:

1. **State lives in Drive/Box, never only in the container.** The source-of-truth
   design isn't just tidy — it's what makes a disposable runtime safe.
2. **The local-CLI bridges (WhatsApp/iMessage) can't live in the cloud box.**
   They run on my always-on Mac; cloud sessions handle the MCP-native surfaces
   (email, files, calendar, contacts). `what-did-i-miss` degrades gracefully:
   it triages whatever surfaces are reachable and says which it skipped.

The recurring "what did I miss?" sweep is wired two ways:

- **SessionStart hook** (`.claude/settings.json` → `scripts/session-greeting.sh`):
  every session opens with the date in Pacific, which chat bridges are reachable
  this session, and a nudge to run the triage. The script is cloud-safe — it
  detects missing `wacli`/`imsg` and says so instead of erroring.
- **Scheduled sweep** (`/loop` + the `daily-sweep` skill): `/loop 3h /daily-sweep`
  runs the triage on an interval, leading with what's *new* since the last run and
  staying quiet when nothing needs me. Scheduled runs are read-only by contract.

---

## 7. Setup checklist

```
[ ] Confirm MCP connectors authenticated (Gmail, Drive, Box, Calendar, Contacts, Zoom)
[ ] Fill data/contacts.csv (the single highest-leverage step)
[ ] Mirror key Drive/Box docs into data/docs/*.md
[ ] Encode taste in memory/preferences.md
[ ] macOS only: run scripts/setup.sh to add wacli / telegram / imsg
[ ] Grant macOS perms for the bridges: Full Disk Access (imsg), Accessibility
[ ] Review .claude/settings.json approval tiers — tighten to taste
[ ] Run /what-did-i-miss and start the feedback loop
```

---

## 8. Layout

```
noor-assets/
├── CLAUDE.md                 # operating rules — auto-loaded every session
├── README.md                 # this proposal
├── .claude/
│   ├── settings.json         # approval tiers + SessionStart hook
│   ├── CONNECTORS.md         # which MCP server = which capability, + CLI patterns
│   └── skills/
│       ├── what-did-i-miss/SKILL.md
│       ├── daily-sweep/SKILL.md      # what-did-i-miss on a /loop timer
│       ├── inbox-zero/SKILL.md
│       ├── contacts/SKILL.md
│       ├── intro-broker/SKILL.md
│       └── personal-admin/SKILL.md
├── data/
│   ├── README.md
│   ├── contacts.csv          # the spreadsheet that's worth more than it looks
│   └── docs/                 # agent-readable mirrors of Drive/Box docs
│       ├── car_info.example.md
│       └── family_info.example.md
├── memory/
│   └── preferences.md        # my taste, encoded
└── scripts/
    ├── setup.sh              # macOS: install wacli / telegram / imsg bridges
    └── session-greeting.sh   # printed by the SessionStart hook (cloud-safe)
```

> This setup is still a little ugly. CLIs are rough, permissions are annoying,
> browser automation is brittle. That's how the future usually starts: a model
> in a terminal with access to your files, accounts, memories, and tools.
