# Operating Guide — How to Use Your Personal Agent

This is the **human** manual. `CLAUDE.md` is the agent's rulebook; this is yours.
It tells you what to say, what comes back, and where the agent will stop and ask.

> The mental model: you state an **outcome**, the agent does the **glue work**
> across your tools, and it stops at the moments that matter to get your okay.
> You are never the one copy-pasting between five apps. You are the approver.

---

## 1. The one habit that makes it work

Ask for the **outcome**, not the steps.

- ❌ "Open Gmail, search for the recruiter, copy her email, then draft…"
- ✅ "Intro my friend's recruiting lead to the recruiter I know. Draft the email."

The agent figures out the path. Your job is to point at the goal and approve the
draft. If you find yourself dictating clicks, you're working too hard.

---

## 2. The five things you'll actually say

| You say… | What happens | Skill |
|---|---|---|
| **"What did I miss?"** | First-pass triage across Gmail, Calendar, Drive/Box (and chats on macOS). You get a ranked digest: who needs you, what's urgent, what's noise. Nothing is sent. | `what-did-i-miss` |
| **"Run inbox zero"** | Sorts the inbox, drafts replies in your voice, shows them to you. You approve, you send. | `inbox-zero` |
| **"Find / add / dedupe a contact"** | Looks up a person across `contacts.csv` + Contacts, or adds/merges (asks first). | `contacts` |
| **"Intro X to Y"** | Reads the thread, finds emails, researches context, drafts the intro with links. You send; it confirms back. | `intro-broker` |
| **"I have a new \<plate / address / policy\>"** | Updates your source-of-truth doc (preserving every other field), then offers to propagate it to portals. | `personal-admin` |

You can invoke them explicitly as slash commands (`/what-did-i-miss`,
`/inbox-zero`, …) or just describe the job in plain language — the agent picks
the right one.

---

## 3. The approval model — when it acts vs. asks

Three tiers. This is *enforced by the system*, not by the agent's goodwill.

| Tier | What it covers | Behavior |
|---|---|---|
| 🟢 **Just does it** | Reading, searching, **drafting** anything, writing local notes | No interruption. Drafts are always safe — they go nowhere until you act. |
| 🟡 **Asks first** | Creating a calendar event, uploading a file, updating a contact, sending a WhatsApp/Telegram/iMessage | Stops and asks before doing it. |
| 🔴 **Asks + spells it out** | Deleting, sending to many people, payments, account settings | Stops, restates exactly what will happen and to whom, then waits. |

**Two structural safety nets you should know about:**
1. **The agent cannot send email.** The Gmail connector only drafts. Every email
   ends as a draft in your Gmail that *you* press send on. This is deliberate.
2. **Nothing survives unless it's saved.** Cloud sessions are disposable, so the
   agent keeps the durable truth in Google Drive / Box and this repo — never only
   in its own memory.

**You can loosen it for people you're close to.** A direct order like *"text my
wife I'm 10 min late"* skips the gate. Social-nuance stuff (investors, customers,
intros, anything to a group) always gets drafted first.

---

## 4. What the agent knows about you

It reads these every session so you don't repeat yourself:

- **`memory/preferences.md`** — your voice and rules. Sign as **Ziad**, keep it
  short, never suggest a phone call, Pacific time, preserve email cc's. *Add to
  this whenever you correct the agent and the fix sticks forever.*
- **`data/contacts.csv`** — everyone you know: email, phone, handles, category,
  notes. This is the single highest-leverage file. The richer it is, the less the
  agent has to hunt. The notes column carries nuance ("email only, never text").
- **`data/docs/*.md`** — mirrors of important docs (car, family) the agent can
  read and update.

**The most valuable thing you can do today:** spend 20 minutes filling
`contacts.csv` with real people. It turns "find her email" from a search into a
lookup.

---

## 5. Running it on autopilot

- **Every session greets you.** A SessionStart hook prints the date, which chat
  surfaces are reachable, and a nudge to triage. You saw it at the top of this
  session.
- **Scheduled triage.** `/loop 3h /daily-sweep` runs "what did I miss?" every few
  hours on its own. It leads with what's *new*, stays quiet when nothing needs
  you, respects quiet hours (9pm–7am), and never sends anything on a timer.
  Start it once; stop it by ending the loop.

---

## 6. Where it can and can't reach

| Surface | Status | Notes |
|---|---|---|
| Gmail, Drive, Box, Calendar, Contacts, Zoom | ✅ Everywhere | Native connectors. Work in cloud + desktop. |
| Canva, Gamma | ✅ Everywhere | Decks / one-pagers. |
| WhatsApp, Telegram, iMessage | ⚠️ macOS only | Run via local bridges on your always-on Mac. In a cloud session the agent says it skipped them — it never pretends it checked. |
| Web portals (DMV, insurance, FasTrak…) | ⚠️ Browser automation | Last resort, for sites with no API. Always asks before submitting a form. |

If a surface is unreachable, the agent **tells you which one it skipped** rather
than silently giving you a partial answer.

---

## 7. Making it better over time

This is the part that compounds. When the agent gets something wrong, tell it,
and tell it to make the fix permanent. It routes the correction to the right place:

| You correct… | Where it's saved | Result |
|---|---|---|
| A preference ("don't sign with my last name") | `memory/preferences.md` | Never happens again. |
| A judgment call ("you archived too aggressively") | the relevant `SKILL.md` | The procedure tightens. |
| A tool gotcha ("that portal needs 2FA") | `CLAUDE.md` | A guardrail for next time. |

You're not re-prompting the same fixes forever — each correction is a permanent
upgrade. That's what turns a generic assistant into *your* operator.

---

## 8. Quick start

```
1. Fill data/contacts.csv with real people.            ← highest leverage
2. Drop your real car/family docs into data/docs/ (or just point the agent at Drive).
3. Skim memory/preferences.md — fix anything that isn't you.
4. Say "what did I miss?" and go from there.
5. Every time you correct it, say "remember that."
```

That's the whole thing. State the outcome, approve the draft, correct it once.
