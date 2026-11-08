---
name: droid-lint
description: Check and tidy a droid's wiki.
argument-hint: "[name]"
disable-model-invocation: true
---

Droid: the argument, or the droid of this session (`.ai/droids/droids.md` → "Session file"). Check that this session is the droid: `${CLAUDE_SESSION_ID}` equals `session=` in its `session.ini`. If not, stop and tell the user to run `/droid-load <name>`.

1. Lint the wiki (`droids.md` → "Wiki" → "Lint"): fix the mechanical issues, report the rest.
2. Report fixes and findings. Ask whether to commit.
