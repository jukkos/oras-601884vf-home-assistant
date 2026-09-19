#!/usr/bin/env bash
set -euo pipefail

MODEL="${OLLAMA_MODEL:-qwen3-coder:30b}"

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 path/to/esphome-serial.log" >&2
  exit 2
fi

LOG="$1"
if [[ ! -f "$LOG" ]]; then
  echo "File not found: $LOG" >&2
  exit 2
fi

{
  cat <<'PROMPT'
You are triaging an ESPHome/ESP32 serial log for an intermittent connectivity problem.
Do not suggest firmware changes yet.

Classify each relevant event as one of:
1. Wi-Fi authentication/association failure
2. AP/BSSID reassociation or roaming
3. DHCP/IP problem
4. ESPHome API-only disconnect
5. ESP32 reboot/reset/brownout/watchdog
6. unknown

Return only:
- exact relevant log lines/timestamps
- classification
- confidence (low/medium/high)
- one next diagnostic test

Do not invent events that are not present in the log.
PROMPT
  echo
  cat "$LOG"
} | ollama run "$MODEL"
