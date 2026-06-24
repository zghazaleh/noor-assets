---
name: inbox-zero
description: Process the Gmail inbox to zero. Separates auto-archivable noise from threads that need me, quotes the substance, drafts replies in my voice, waits for explicit approval, and labels/archives only after I have sent. Preserves all recipients. Signs as Ziad.
---

# inbox-zero

Turn a full inbox into a short list of decisions. The procedure *is* the product.

## Procedure

1. **List** recent inbox threads via Gmail `search_threads`.

2. **Classify** each thread:
   - **Auto-archive** — newsletters, receipts, notifications, no action needed.
   - **Needs review** — a human expects something, or it's important.

3. **For the needs-review set**, present each as:
   - From / subject / age
   - 2–3 line summary of the **substance** (not the whole email)
   - Recommendation: `archive` | `reply` | `defer`
   - If reply: a **drafted response** in my voice — short, no suggested calls
     unless I asked, signed **Ziad**.

4. **Wait for explicit approval** on each draft. Never send. (The Gmail connector
   has no send tool — leave the approved text as a `create_draft` for me to send.)

5. **After I confirm I've sent**, label/archive the thread. Reply **in the original
   thread**; **preserve every recipient** (to + cc). Never drop a cc.

6. **Archive only after sending**, never before.

## Rules / accumulated taste
- Keep replies short. No corporate signature block. Sign **Ziad**.
- Never suggest a phone call unless I explicitly ask for one.
- When unsure whether something is noise, default to **needs review**, not archive.
- Batch the auto-archive list at the end as a single "archive these N?" confirmation.
- If a thread needs info from another tool (a doc, a contact, a date), fetch it
  first so the draft is complete, then present.
