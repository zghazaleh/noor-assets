---
name: daily-sweep
description: >-
  The recurring wrapper around what-did-i-miss. Run on a schedule (via /loop) so
  the life-inbox triage happens on its own and lands as a short digest I can act
  on. Read-only first pass; never sends or mutates without me.
---

# daily-sweep

`what-did-i-miss` is the manual triage. `daily-sweep` is the same thing on a
timer, so I don't have to remember to ask.

## How to run it on a schedule
Use the `/loop` skill to repeat this on an interval. Examples:
```
/loop 3h /daily-sweep        # every 3 hours during the day
/loop 1d /daily-sweep        # once a day
```
`/loop` re-invokes this skill on the interval; each run is independent and
read-only, so it's safe to leave running.

## Procedure
1. Run the `what-did-i-miss` skill end to end (Gmail, Calendar, Drive/Box, and the
   chat bridges if this is a macOS session).
2. Produce the digest in that skill's output shape.
3. **Diff against the previous sweep** when possible — lead with what's *new or
   newly urgent* since last run, so repeated sweeps don't re-surface the same items.
4. If nothing is actionable, say so in one line ("nothing new needs you") rather
   than re-printing a full empty report.
5. **Stop there.** Never draft, send, or create on a scheduled run — surfacing is
   the job. I'll point at items and hand off to inbox-zero / intro-broker.

## Taste
- A scheduled run that finds nothing should be quiet, not noisy.
- Only escalate (🔴) things with a real deadline or a person actively waiting.
- Respect quiet hours: between 9pm–7am Pacific, hold non-urgent items for the
  morning sweep unless something is genuinely time-critical.
