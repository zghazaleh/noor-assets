# Family info — example mirror (replace with the real doc, keep synced to Drive/Box)

# This is an agent-readable mirror of a doc whose live source of truth lives in
# Google Drive / Box. Edit here, then push the change back per the personal-admin
# skill, preserving every field you weren't explicitly asked to change.

household:
  timezone: America/Los_Angeles
  address_on_file: <street, city, ZIP>          # private — never surface unless asked

members:
  - name: Ziad
    role: self
    email: zghazaleh@gmail.com
  - name: <spouse>
    role: spouse
    phone: <number>                             # private
    notes: <close contact — low-stakes one-liners may skip the approval gate>
  - name: <child>
    role: child
    dob: <YYYY-MM-DD>
    school: <school>

key_dates:                                       # surface these in daily-sweep
  - 2026-09-01  <example: school year starts>
  - <anniversary / birthdays>

providers:
  pediatrician: <name / portal>
  dentist: <name / portal>

# Notes:
# - Anything marked "private" stays out of digests unless the task needs it.
# - key_dates is what what-did-i-miss / daily-sweep should watch for upcoming events.
