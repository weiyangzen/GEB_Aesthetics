#!/bin/bash
# Generate L1-L5 specifications

set -euo pipefail

readonly OUT_DIR="${1:-./geb_output}"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/scripts/_evo_guard.sh"
evo_init
evo_log "generate" "start out_dir=${OUT_DIR}"

echo "🎨 GEB Aesthetics: Generating specifications..."
echo "   This creates the 5-layer recursive Spec system"
echo ""

run_with_retry 3 mkdir -p "${OUT_DIR}"

cat > "${OUT_DIR}/L1_Worldview.md" << 'EOF'
# L1 Worldview
- Cosmology
- Social structure
- Boundary rules
EOF

cat > "${OUT_DIR}/L2_Character.md" << 'EOF'
# L2 Character
- Core motivation
- Internal contradiction
- Relationship graph
EOF

cat > "${OUT_DIR}/L3_Narrative.md" << 'EOF'
# L3 Narrative
- Conflict matrix
- Information release rhythm
- Structure template
EOF

cat > "${OUT_DIR}/L4_Beat.md" << 'EOF'
# L4 Beat
- Emotional arc by scene
- Rhythm markers
- Transition constraints
EOF

cat > "${OUT_DIR}/L5_Execution.md" << 'EOF'
# L5 Execution
- Shot plan
- Audio motifs
- Visual grammar and pacing
EOF

echo "📋 L1: Worldview Layer - Universe constitution"
echo "📋 L2: Character Layer - Agency and relationships"
echo "📋 L3: Narrative Layer - Plot architecture"
echo "📋 L4: Beat Layer - Scene sequencing"
echo "📋 L5: Execution Layer - Final encoding"
echo ""
echo "✅ Specifications generated"
echo "📁 Output: ${OUT_DIR}"
evo_log "generate" "completed out_dir=${OUT_DIR}"
