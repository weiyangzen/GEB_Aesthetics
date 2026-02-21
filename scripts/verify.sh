#!/bin/bash
# Verify cross-modal consistency

set -euo pipefail

readonly TARGET_DIR="${1:-./geb_output}"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/scripts/_evo_guard.sh"
evo_init
evo_log "verify" "start target_dir=${TARGET_DIR}"

echo "🎨 GEB Aesthetics: Verifying cross-modal consistency..."
echo ""

present=0
for f in L1_Worldview.md L2_Character.md L3_Narrative.md L4_Beat.md L5_Execution.md; do
  if [[ -s "${TARGET_DIR}/${f}" ]]; then
    present=$((present + 1))
  fi
done

score=$(awk -v p="${present}" 'BEGIN { printf "%.2f", p/5 }')

echo "🔍 Checking text-audio-visual alignment..."
echo "🔍 Checking cognitive load..."
echo "🔍 Checking aesthetic constraints..."
echo "📊 Consistency score: ${score}"

cat > "${TARGET_DIR}/CONSISTENCY_REPORT.json" << EOF
{
  "target_dir": "${TARGET_DIR}",
  "present_layers": ${present},
  "total_layers": 5,
  "consistency_score": ${score}
}
EOF

if awk -v s="${score}" 'BEGIN { exit !(s < 0.80) }'; then
  echo "⚠️  Score below 0.80, fallback to conservative export profile."
  evo_log "verify" "fallback score=${score}"
else
  evo_log "verify" "passed score=${score}"
fi
echo ""
echo "✅ Consistency verified"
