---
name: droid-clone
description: Create a new droid from an existing one, with the same role and wiki but a fresh inbox, and a different specialization.
argument-hint: "<source> [name] [how it differs]"
disable-model-invocation: true
---

Read `.ai/droids/droids.md` first.

1. Name and difference: use the arguments if given. Otherwise infer them from this conversation and the source droid's `droid.md`.
2. Run `.ai/droids/.bin/droid clone <source> <name>`.
3. Update the new droid's `droid.ini` description and `droid.md` to its specialization. Leave pages that do not concern it out of its `index.md` and remove them.
4. Report the new droid in one sentence. Do not load it unless asked.
