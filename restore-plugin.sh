#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

PLUGIN="${1:?Usage: ./restore-plugin.sh <plugin-name>}"

# Find the most recent "Remove plugin: <name>" commit
REMOVE_COMMIT=$(git log --oneline --all --grep="Remove plugin: $PLUGIN" -1 --format="%H")

if [ -z "$REMOVE_COMMIT" ]; then
  echo "Error: no removal commit found for '$PLUGIN'"
  exit 1
fi

if [ -d "$PLUGIN" ]; then
  echo "Error: plugin directory '$PLUGIN' already exists — already restored?"
  exit 1
fi

git revert --no-edit "$REMOVE_COMMIT"
git push

echo "Done. Restored '$PLUGIN' to marketplace."
