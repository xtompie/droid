---
name: droid-destroy
description: Remove a droid whose topic is finished.
argument-hint: "<name>"
disable-model-invocation: true
---

1. `.ai/droids/<name>/droid.ini` must exist. If not, say so and stop.
2. If `session.ini` exists, its `session=` is not `${CLAUDE_SESSION_ID}` and the lookup (`.ai/droids/droids.md` → "Session file") finds it alive: the droid is loaded in another live session. Refuse and say so.
3. `git status --porcelain .ai/droids/<name>`. Any output means changes that are not in git: show them and ask once: remove anyway, losing them? On no, stop. No output: everything is in git, no confirmation needed.
4. `rm -r .ai/droids/<name>`
5. Say the droid is gone and its history stays in git. Ask whether to commit the removal.
