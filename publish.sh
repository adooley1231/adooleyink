#!/usr/bin/env bash
# Strip admin layer from the canonical portfolio + commit + push.
# Use after editing /Users/annadooley/Downloads/anna-dooley-portfolio.html.
#
# Usage:  ./publish.sh "commit message"
set -euo pipefail

CANONICAL="/Users/annadooley/Downloads/anna-dooley-portfolio.html"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
PUBLIC="$REPO_DIR/index.html"
MSG="${1:-Update portfolio}"

if [[ ! -f "$CANONICAL" ]]; then
  echo "ERROR: canonical file not found at $CANONICAL" >&2
  exit 1
fi

cp "$CANONICAL" "$PUBLIC"

# Find admin block boundaries dynamically so this survives unrelated edits.
PHASE1_LINE=$(grep -n "ADMIN LAYER — Phase 1.1" "$PUBLIC" | head -1 | cut -d: -f1 || true)
if [[ -z "$PHASE1_LINE" ]]; then
  echo "No admin block found — copying canonical as-is."
else
  START=$((PHASE1_LINE - 1))          # the <!-- ===== line just above the Phase 1.1 comment
  END=$(grep -n "^</script>$" "$PUBLIC" | tail -1 | cut -d: -f1)
  sed -i '' "${START},${END}d" "$PUBLIC"
  echo "Stripped admin lines $START-$END"
fi

echo "Public file: $(wc -l < "$PUBLIC" | tr -d ' ') lines, $(wc -c < "$PUBLIC" | tr -d ' ') bytes"
echo "Remaining 'admin' refs (case-study text only): $(grep -ic admin "$PUBLIC")"

cd "$REPO_DIR"
git add index.html
if git diff --cached --quiet; then
  echo "No changes to commit."
  exit 0
fi
git commit -m "$MSG"
git push
echo "Pushed. Live in ~30-60s at https://adooley1231.github.io/adooleyink/"
