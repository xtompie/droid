---
name: droid-wake
description: Wake a sleeping droid in this session: load it and work through its inbox, starting with the given message. This is the command a sleeping droid is started with, `claude "/droid-wake <name> <inbox file>"`.
argument-hint: "<name> [inbox file]"
disable-model-invocation: true
---

This session's id is `${CLAUDE_SESSION_ID}`. Wherever the files below say `${CLAUDE_SESSION_ID}`, use this id. They live next to this skill in the skills folder (usually `.claude/skills/`).

1. Read `droid-load/SKILL.md` and do its steps for `<name>`.
2. Read `droid-work/SKILL.md` and do its steps for `<name>`, until the inbox has nothing left to do now. If an inbox file was given, take that file first, then the rest.
