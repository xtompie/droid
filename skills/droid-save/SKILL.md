---
name: droid-save
description: Close a stretch of work: fold missing knowledge into the droid's wiki and fix mechanical wiki issues.
argument-hint: "[name]"
disable-model-invocation: true
---

Droid: the argument, or the droid of this session (`.ai/droids/droids.md` → "Session file"). Check that this session is the droid: `${CLAUDE_SESSION_ID}` equals `session=` in its `session.ini`. If not, stop and tell the user to run `/droid-load <name>`.

1. Knowledge from this session that is not in the wiki yet: fold it in (`droids.md` → "Wiki"). If the next session needs to know what is in progress, that goes into a wiki page too.
2. Light lint, fixes only: every page has a line in `index.md`, no index lines to missing files, no broken links.
3. Report in one line what changed. Ask whether to commit.
