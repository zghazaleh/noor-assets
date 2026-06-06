# Car info — seed data (clearly fake, but complete so workflows run end-to-end)

# Agent-readable mirror of a doc whose live source of truth lives in Drive/Box.
# Edit here, then push back per the personal-admin skill, preserving every field
# you weren't explicitly asked to change.

vehicle: 2022 Lexus RX 350
license_plate: 7XYZ456
vin: JTJBARBZ1N2099887            # fake VIN — placeholder
registration_notes: Renewed 2026-02; tags expire 2027-02.
insurance:
  carrier: Summit Insurance
  policy: SUM-AUTO-4471902        # fake policy #
  agent: Hassan Karim             # see contacts.csv
owners:
  - Ziad Ghazaleh
  - Layla Ghazaleh
address_on_file: 1200 Market St, San Francisco, CA 94102   # private — don't surface unless asked
service:
  mechanic: Marcus Webb / Webb Auto Care   # see contacts.csv
  last_service: 2026-04-15 (oil + tire rotation)
  next_due: 2026-10-15

portals_holding_this_info:        # where personal-admin propagates a change
  - DMV (registration)
  - Summit Insurance portal
  - FasTrak (plate on file)
  - SpotHero / parking app

# When updating ONE field (e.g. a new plate), preserve every other field, then
# propagate to the portals above — asking before each submission.
