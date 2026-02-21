#!/bin/bash
# EvoMap guard for creative pipeline reliability.

set -euo pipefail

readonly EVO_STATE_DIR="${SCRIPT_DIR}/.evo"
readonly EVO_LOG="${EVO_STATE_DIR}/events.log"

evo_init() {
  mkdir -p "${EVO_STATE_DIR}"
  touch "${EVO_LOG}"
}

evo_log() {
  local phase="$1"
  local message="$2"
  printf "%s\t%s\t%s\n" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "${phase}" "${message}" >> "${EVO_LOG}"
}

run_with_retry() {
  local attempts="$1"
  shift
  local n=1
  local delay=1
  while true; do
    if "$@"; then
      return 0
    fi
    if [[ "${n}" -ge "${attempts}" ]]; then
      return 1
    fi
    sleep "${delay}"
    delay=$((delay * 2))
    n=$((n + 1))
  done
}
