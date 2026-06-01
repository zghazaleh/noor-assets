---
name: personal-admin
description: Administrative continuity. Update a source-of-truth doc in Drive/Box from a photo or note (preserving all existing fields), then propagate the change to the web portals that have no API — insurance, DMV, FasTrak, parking, etc. — via browser automation, with approval before any submission.
---

# personal-admin

The "license plate" pattern: a single fact changes (new plate, new address, new
card) and it needs to land in the doc *and* in five web portals. Not dramatic
autonomy — administrative continuity.

## Procedure

1. **Capture the change.** From the photo/note I send, extract the specific fields
   that changed (e.g. license plate). Restate them back to me to confirm I got it right.

2. **Update the source-of-truth doc.**
   - Find the doc (e.g. `car_info.md`) in Drive/Box via search.
   - Download it. Edit **only** the changed fields. **Preserve everything else** —
     VIN, insurance, owners, address, registration notes.
   - Re-upload as a new version (`upload_file_version` / Drive create). Cite the file.

3. **Propagate to external systems**, best-tool-first:
   - **Clean systems** → use their API/CLI if one exists.
   - **Messy systems** (FasTrak, parking app, insurance/DMV portals) → browser
     automation. Log in, navigate to the field, fill it.
   - **Before submitting any form**, show me exactly what will change and on which
     site. Wait for approval. Screenshot the confirmation.

4. **Report** a checklist of where it was updated and where it still needs me.

## Rules
- Never overwrite a doc wholesale — diff-think. Preserving untouched fields is the
  whole point.
- Treat every portal submission as ask-tier; never auto-submit.
- If a portal needs a credential I don't have stored, stop and ask — don't guess.
- Keep a running list in the doc of "systems that hold this fact" so next time the
  propagation list is already known.
