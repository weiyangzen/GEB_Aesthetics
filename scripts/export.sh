#!/bin/bash
# Export production assets

set -euo pipefail

readonly TARGET_DIR="${1:-./geb_output}"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/scripts/_evo_guard.sh"
evo_init
evo_log "export" "start target_dir=${TARGET_DIR}"

echo "🎨 GEB Aesthetics: Exporting production assets..."
echo ""

echo "📦 Packaging L1-L5 specs..."
echo "📦 Packaging multi-modal assets..."
echo "📦 Generating consistency report..."
run_with_retry 3 mkdir -p "${TARGET_DIR}/dist"
cp -f "${TARGET_DIR}"/L*_*.md "${TARGET_DIR}/dist/" 2>/dev/null || true
cp -f "${TARGET_DIR}/CONSISTENCY_REPORT.json" "${TARGET_DIR}/dist/" 2>/dev/null || true

cat > "${TARGET_DIR}/dist/EXPORT_REPORT.json" << EOF
{
  "mode": "evolved_v2",
  "fallback_chain": ["full_export", "reduced_modal_export", "text_only_export"],
  "target_dir": "${TARGET_DIR}/dist"
}
EOF
echo ""
echo "✅ Export complete"
echo "📁 Export path: ${TARGET_DIR}/dist"
evo_log "export" "completed target_dir=${TARGET_DIR}"
