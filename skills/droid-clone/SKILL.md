---
name: droid-clone
description: Create a new droid from an existing one, with the same role and wiki but a fresh inbox, and a different specialization.
argument-hint: "<source> [name] [how it differs]"
disable-model-invocation: true
---

Read `.ai/droids/droids.md` first.

1. Name and difference: use the arguments if given. Otherwise infer them from this conversation and the source droid's `droid.md`.
2. `ls .ai/droids`. If a folder with that name exists, pick another and say so.
3. Copy the source droid's `droid.ini`, `droid.md`, `index.md` and wiki pages into `.ai/droids/<name>/`. Do not copy `session.ini` or the inbox. `mkdir -p .ai/droids/<name>/inbox`.
4. In the copy: set `name=` and `description=` in `droid.ini` and `created=` to `date +%Y-%m-%d`. Update `droid.md` to the new specialization. Remove pages that do not concern it and their lines in `index.md`.
5. Report the new droid in one sentence. Do not load it unless asked.
