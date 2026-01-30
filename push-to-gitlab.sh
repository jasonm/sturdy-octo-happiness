#!/usr/bin/env bash
# Creates a gitlab-main branch from current main with the marketplace name
# changed to "productivity-tools-gitlab", then pushes it as gitlab's main.
set -euo pipefail
cd "$(dirname "$0")"

git checkout -B gitlab-main main
python3 -c "
import json
with open('.claude-plugin/marketplace.json') as f:
    data = json.load(f)
data['name'] = 'productivity-tools-gitlab'
with open('.claude-plugin/marketplace.json', 'w') as f:
    json.dump(data, f, indent=2)
    f.write('\n')
"
git add .claude-plugin/marketplace.json
git commit --amend --no-edit
git push gitlab gitlab-main:main --force
git checkout main
