#!/usr/bin/env bash
# session-greeting.sh — printed into context by the SessionStart hook.
# Cloud-safe: no macOS dependencies. Tells the agent (and me) what surfaces are
# reachable this session and nudges the daily triage.
set -euo pipefail

export TZ="America/Los_Angeles"
NOW="$(date '+%A %Y-%m-%d %H:%M %Z')"

# Detect whether the local messaging bridges exist (macOS, always-on Mac only).
have() { command -v "$1" >/dev/null 2>&1; }
bridges=()
have wacli && bridges+=("WhatsApp")
have tgcli && bridges+=("Telegram")
have imsg  && bridges+=("iMessage")
if [ "${#bridges[@]}" -eq 0 ]; then
  bridge_line="Local chat bridges: none reachable (cloud session — WhatsApp/Telegram/iMessage skipped)."
else
  bridge_line="Local chat bridges reachable: ${bridges[*]}."
fi

cat <<EOF
[personal-agent] Session start — ${NOW} (America/Los_Angeles).
${bridge_line}
MCP surfaces (Gmail, Drive, Box, Calendar, Contacts, Zoom) authenticate via Claude connectors.
Reminder: run /what-did-i-miss for a first-pass triage. Read memory/preferences.md before drafting.
EOF
