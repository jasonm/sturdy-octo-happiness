#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

# Read current version and increment
CURRENT=$(cat VERSION)
NEXT=$((CURRENT + 1))

echo "Bumping from v${CURRENT} to v${NEXT}"

# Write new VERSION
echo "$NEXT" > VERSION

# --- meeting-prep plugin.json ---
cat > meeting-prep/.claude-plugin/plugin.json <<EOF
{
  "name": "meeting-prep",
  "description": "Helps prepare for meetings by pulling context and drafting agendas",
  "commands": {
    "briefing-v${NEXT}": {
      "source": "./commands/briefing.md",
      "description": "Prepare a briefing doc for an upcoming meeting. Takes a meeting topic or calendar event as input and produces a structured agenda with context. (v${NEXT})"
    }
  }
}
EOF

# --- meeting-prep command ---
cat > meeting-prep/commands/briefing.md <<EOF
---
description: "Prepare a meeting briefing (v${NEXT})"
---

# Briefing Command (v${NEXT})

This is the briefing slash command, version ${NEXT}.

When invoked, prepare a meeting briefing by:

1. Asking the user for the meeting topic or calendar event details if not provided as an argument.
2. Using the filesystem MCP to check \`/tmp/meeting-notes\` for related prior notes.
3. Drafting a structured agenda with objectives, attendees, agenda items with time allocations, and open questions.
4. Saving the result to \`/tmp/meeting-notes\` via the filesystem MCP.

---
Command version: ${NEXT}
EOF

# --- meeting-prep skill ---
cat > meeting-prep/skills/prepare-briefing.md <<EOF
# Meeting Briefing Preparation (v${NEXT})

You are preparing a briefing document for an upcoming meeting.
This is version ${NEXT} of the meeting-prep briefing skill.

Follow these steps:

1. Identify the meeting topic and participants from the user's input.
2. Use the filesystem MCP server to check \`/tmp/meeting-notes\` for any existing notes, prior agendas, or context documents related to the topic or participants.
3. Gather relevant context about each participant's role and recent contributions to the topic.
4. Draft a structured agenda in markdown with the following sections:
   - **Meeting objective** — a one-sentence summary of the meeting's purpose
   - **Attendees** — list of participants with brief role descriptions
   - **Background context** — key facts and prior decisions relevant to the discussion
   - **Agenda items** — numbered list with suggested time allocations (e.g., "10 min")
   - **Open questions** — unresolved items to address during the meeting
   - **Pre-reads** — links or references attendees should review beforehand
5. Save the completed briefing as a markdown file in \`/tmp/meeting-notes\` using the filesystem MCP, named with the format \`briefing-YYYY-MM-DD-<topic-slug>.md\`.
6. Present the briefing to the user and ask if any adjustments are needed.

---
Skill version: ${NEXT}
EOF

# --- research-digest plugin.json ---
cat > research-digest/.claude-plugin/plugin.json <<EOF
{
  "name": "research-digest",
  "description": "Synthesizes research from multiple web sources into a concise digest",
  "commands": {
    "digest-v${NEXT}": {
      "source": "./commands/digest.md",
      "description": "Create a research digest on a topic. Fetches sources from the web and produces a structured summary with key findings and citations. (v${NEXT})"
    }
  }
}
EOF

# --- research-digest command ---
cat > research-digest/commands/digest.md <<EOF
---
description: "Create a research digest (v${NEXT})"
---

# Digest Command (v${NEXT})

This is the digest slash command, version ${NEXT}.

When invoked, create a research digest by:

1. Asking the user for the research topic if not provided as an argument.
2. Using the fetch MCP to retrieve 3-5 relevant web pages on the topic.
3. Extracting key findings, evidence, and limitations from each source.
4. Producing a structured digest with topic overview, key findings, source summaries, synthesis, and citations.

---
Command version: ${NEXT}
EOF

# --- research-digest skill ---
cat > research-digest/skills/summarize-sources.md <<EOF
# Research Digest (v${NEXT})

You are creating a research digest on a topic provided by the user.
This is version ${NEXT} of the research-digest summarize-sources skill.

Follow these steps:

1. Identify the research topic and any specific angles or questions the user wants addressed.
2. Use the fetch MCP server to retrieve 3-5 relevant web pages on the topic. Prioritize authoritative sources such as academic publications, official documentation, and reputable news outlets.
3. For each source, extract:
   - The main thesis or key finding
   - Supporting data points or evidence
   - Any notable limitations or caveats mentioned
4. Produce a structured digest in markdown with the following sections:
   - **Topic overview** — a 2-3 sentence summary of the research area
   - **Key findings** — bullet-point summaries of the most important discoveries or conclusions across all sources
   - **Source summaries** — for each source, a brief paragraph with the title, URL, and main takeaways
   - **Synthesis** — common themes, contradictions, or gaps identified across sources
   - **Citations** — numbered list of all source URLs for reference
5. Present the digest to the user and offer to dive deeper into any specific finding or source.

---
Skill version: ${NEXT}
EOF

# Commit and push
git add -A
git commit -m "Bump plugin commands and skills to v${NEXT}"
git push

echo "Done. Plugins now at v${NEXT} (commands: briefing-v${NEXT}, digest-v${NEXT})"
