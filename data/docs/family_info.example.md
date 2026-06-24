# Family info — seed data (clearly fake, but complete so workflows run end-to-end)

# Agent-readable mirror; live source of truth in Drive/Box. Preserve fields you
# weren't asked to change.

household:
  timezone: America/Los_Angeles
  address_on_file: 1200 Market St, San Francisco, CA 94102   # private

members:
  - name: Ziad Ghazaleh
    role: self
    email: zghazaleh@gmail.com
  - name: Layla Ghazaleh
    role: spouse
    email: layla.ghazaleh@example.com
    phone: +1-415-555-0101          # private
    notes: Close contact — low-stakes one-liners ("running 10 late") may skip the approval gate.
  - name: Yusuf Ghazaleh
    role: child
    dob: 2018-09-12
    school: Mission Bay Elementary

key_dates:                          # surface upcoming ones in what-did-i-miss / daily-sweep
  - 2026-09-12  Yusuf's birthday
  - 2026-06-21  Anniversary (Ziad & Layla)
  - 2026-08-24  School year starts

providers:
  pediatrician: Bay Kids Pediatrics
  dentist: Marina Dental

# Notes:
# - "private" fields stay out of digests unless the task needs them.
# - key_dates is what the sweep watches for upcoming events.
