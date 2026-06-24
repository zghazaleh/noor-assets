---
name: intro-broker
description: Broker an introduction that starts in a chat (WhatsApp/Telegram/iMessage) and ends in a sent email. Reads the thread, finds the person's email, researches the relevant company/context on the web, drafts the intro with the right links, draft → I send → confirm back on the original chat.
---

# intro-broker

The signature cross-tool workflow. Someone asks me to connect two people; I want
the *outcome*, not twenty minutes of app-switching.

## Procedure

1. **Read the request** in the originating chat (`wacli`/`tgcli`/`imsg messages
   list`, or Gmail if it came by email). Extract: who wants to meet whom, why, and
   any links/attachments they sent.

2. **Resolve the people.** Look up each person's email via the `contacts` skill
   (CSV → Contacts server → Gmail history). If I don't have an email, search Gmail
   for prior threads with them.

3. **Research for credibility.** Use web search to understand the company/context
   (recent funding, news, what makes it credible) so the intro isn't hollow.
   Include the specific links the requester wanted forwarded (e.g. job posts).

4. **Draft the intro email** in my voice (short, warm, double-opt-in friendly):
   - clear one-line "why you two should talk"
   - one line on each person
   - the relevant links
   - signed **Ziad**
   Leave it as a Gmail `create_draft` (no send tool — that's the gate).

5. **Show me the draft. Wait for approval.** Preserve all intended recipients.

6. **After I send**, message the original requester back on the same channel:
   "Done — intro sent." (ask-tier send via the CLI.)

## Rules
- Don't send the intro to people who haven't opted in if the request implies a
  double-opt-in; when in doubt, draft a "mind if I intro you?" ping first.
- Always include the exact links the requester asked to pass along.
- Keep research tight — credibility, not a dossier.
