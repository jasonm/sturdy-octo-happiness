#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

PLUGIN="${1:?Usage: ./remove-plugin.sh <plugin-name>}"

if [ ! -d "$PLUGIN" ]; then
  echo "Error: plugin directory '$PLUGIN' not found"
  exit 1
fi

# Remove plugin directory
rm -rf "$PLUGIN"

# Rewrite marketplace.json without the removed plugin
# Read current marketplace and filter out the plugin using python (available on macOS)
python3 -c "
import json, sys
with open('.claude-plugin/marketplace.json') as f:
    data = json.load(f)
data['plugins'] = [p for p in data['plugins'] if p['name'] != '$PLUGIN']
with open('.claude-plugin/marketplace.json', 'w') as f:
    json.dump(data, f, indent=2)
    f.write('\n')
"

git add -A
git commit -m "Remove plugin: $PLUGIN"
git push origin main
./push-to-gitlab.sh

echo "Done. Removed '$PLUGIN' from marketplace."
