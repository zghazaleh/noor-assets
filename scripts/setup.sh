#!/usr/bin/env bash
set -euo pipefail

# setup.sh — install the local CLI bridges for surfaces with no MCP server.
# macOS only. These cover WhatsApp / Telegram / iMessage, which run on an
# always-on Mac (not in cloud/web Claude sessions).
#
# The MCP-native surfaces (Gmail, Drive, Box, Calendar, Contacts, Zoom, Canva,
# Gamma, GitHub) need no install — they authenticate through Claude's connectors.

if [[ "$(uname)" != "Darwin" ]]; then
  echo "These bridges are macOS-only. On Linux/web, use the MCP servers + browser automation."
  exit 0
fi

echo "==> WhatsApp (wacli — whatsmeow bridge)"
echo "    Install per https://github.com/ and authenticate by scanning the QR once."
# brew install wacli   # or: go install ...  (adjust to the bridge you choose)

echo "==> Telegram (MTProto / Telethon CLI)"
echo "    Configure API id/hash, then log in once."
# pipx install telethon-cli   # or your preferred connector

echo "==> iMessage / SMS (imsg)"
echo "    Reads ~/Library/Messages/chat.db — grant Full Disk Access to the terminal."
# brew install imsg

cat <<'NOTE'

Permissions to grant (System Settings → Privacy & Security):
  - Full Disk Access   → terminal (imsg reads chat.db)
  - Accessibility      → terminal (UI automation fallback)
  - Screen Recording   → optional visual fallback

Pair these serious permissions with the serious approval gates in
.claude/settings.json. Verify with:
  wacli chats list --json | head
  imsg chats list --json | head
NOTE

echo "Done. See .claude/CONNECTORS.md for command patterns."
