---
name: droid-wake
description: Wake a sleeping droid in this session: load it and work through its inbox. This is the command a sleeping droid is started with, `claude "/droid-wake <name>"`.
argument-hint: "<name>"
disable-model-invocation: true
---

This session's id is `${CLAUDE_SESSION_ID}`. Wherever the files below say `${CLAUDE_SESSION_ID}`, use this id. They live next to this skill in the skills folder (usually `.claude/skills/`).

1. Read `droid-load/SKILL.md` and do its steps for `<name>`.
2. Read `droid-work/SKILL.md` and do its steps for `<name>`, until the inbox has nothing left to do now.
