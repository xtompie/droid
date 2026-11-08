---
name: droid-tasks
description: List what a droid has to do (its inbox) without doing anything.
argument-hint: "[name]"
disable-model-invocation: true
---

Droid: the argument, or the droid of this session (`droids.md` → "Session file").

`ls .ai/droids/<name>/inbox`. For each file show the time (from the file name), the sender (`From:`) and one line of what it asks. Mark files with `Waiting for:` as waiting and files with `Undelivered:` as undelivered, and show the undelivered answer in full. Change nothing.
