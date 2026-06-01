---
name: what-did-i-miss
description: Life inbox triage. Scans Gmail, WhatsApp/Telegram/iMessage (when reachable), Calendar, and recent Drive/Box changes, then reports who needs a reply, what is urgent, what is stale, what can be ignored, and what should become a calendar event or document task. First-pass only — judgment stays with me.
---

# what-did-i-miss

The killer workflow. Run this every few hours to answer one question: **what
needs my attention across everything?** Do the tedious first pass; leave the
judgment to me.

## Procedure

1. **Determine reachable surfaces.** MCP surfaces (Gmail, Calendar, Drive, Box,
   Contacts) are always available. WhatsApp/Telegram/iMessage are only reachable
   on a macOS session via the CLIs. Note which you will skip and say so at the end.

2. **Sweep each surface (read-only, in parallel where possible):**
   - **Gmail** — unread/recent threads in inbox. `search_threads` newer_than:2d.
   - **Messaging** — `wacli`/`tgcli`/`imsg` `messages list` for active chats since
     last sweep. Resolve unknown numbers against `data/contacts.csv`.
   - **Calendar** — events in the next 48h; flag anything unconfirmed or conflicting.
   - **Drive/Box** — files changed recently that I may need to act on.

3. **Classify each item into exactly one bucket:**
   - 🔴 **Needs a reply from me** — who, the ask, my draft-ready stance.
   - 🟠 **Urgent / time-sensitive** — deadline, what happens if ignored.
   - 🟡 **Stale** — I owe someone, aging > 3 days.
   - 📅 **Should become an event** — propose the slot (use `suggest_time`).
   - 📄 **Needs a doc / lookup** — what to find, where.
   - ⚪ **Ignore / FYI** — auto-archivable noise.

4. **Report** as a tight digest, grouped by bucket, newest-relevant first. Quote
   the *substance* of each item, not the whole message. One line per item.

5. **Offer the obvious next actions** ("want me to draft replies to the 3 red
   items?") but **do not act** without my go-ahead. This skill is read-only.

## Rules
- Never send or mutate anything here. It is a scanner.
- If a surface is unreachable, list it under "skipped" — don't silently omit it.
- Keep the whole digest skimmable in ~20 seconds. Brevity is the feature.
