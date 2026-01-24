---
description: "Prepare a meeting briefing (v30)"
---

# Briefing Command (v30)

This is the briefing slash command, version 30.

When invoked, prepare a meeting briefing by:

1. Asking the user for the meeting topic or calendar event details if not provided as an argument.
2. Using the filesystem MCP to check `/tmp/meeting-notes` for related prior notes.
3. Drafting a structured agenda with objectives, attendees, agenda items with time allocations, and open questions.
4. Saving the result to `/tmp/meeting-notes` via the filesystem MCP.

---
Command version: 30
