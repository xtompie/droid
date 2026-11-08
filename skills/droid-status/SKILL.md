---
name: droid-status
description: Show all droids with their task count, session state and description.
disable-model-invocation: true
---

For each folder in `.ai/droids/` that has a `droid.ini`:

- name and `description=` from `droid.ini`,
- tasks: number of files in `ls .ai/droids/<name>/inbox`; add `(N undelivered)` when files have an `Undelivered:` line,
- session: read `session.ini` (`droids.md` → "Session file"). `here` if its `session=` is this session's id, `live` if the lookup in "Session file" finds it alive, otherwise `asleep` (also when there is no `session.ini`).

Show one table: droid, tasks, session, description. No droids → say so and mention `/droid-new`. Add nothing else.
