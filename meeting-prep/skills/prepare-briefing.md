# Meeting Briefing Preparation (v36)

You are preparing a briefing document for an upcoming meeting.
This is version 36 of the meeting-prep briefing skill.

Follow these steps:

1. Identify the meeting topic and participants from the user's input.
2. Use the filesystem MCP server to check `/tmp/meeting-notes` for any existing notes, prior agendas, or context documents related to the topic or participants.
3. Gather relevant context about each participant's role and recent contributions to the topic.
4. Draft a structured agenda in markdown with the following sections:
   - **Meeting objective** — a one-sentence summary of the meeting's purpose
   - **Attendees** — list of participants with brief role descriptions
   - **Background context** — key facts and prior decisions relevant to the discussion
   - **Agenda items** — numbered list with suggested time allocations (e.g., "10 min")
   - **Open questions** — unresolved items to address during the meeting
   - **Pre-reads** — links or references attendees should review beforehand
5. Save the completed briefing as a markdown file in `/tmp/meeting-notes` using the filesystem MCP, named with the format `briefing-YYYY-MM-DD-<topic-slug>.md`.
6. Present the briefing to the user and ask if any adjustments are needed.

---
Skill version: 36
