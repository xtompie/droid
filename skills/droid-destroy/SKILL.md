---
name: droid-destroy
description: Remove a droid whose topic is finished.
argument-hint: "<name>"
disable-model-invocation: true
---

1. Run `.ai/droids/bin/droid destroy-check <name>`.
   - Exit 3 (`live`): the droid is loaded in another live session. Refuse and say which.
   - Exit 4 (`uncommitted`): show the changes and ask once: remove anyway, losing them? On no, stop.
   - `ok`: everything is in git; no confirmation needed.
2. Run `.ai/droids/bin/droid destroy <name>`.
3. Say the droid is gone and its history stays in git. Ask whether to commit the removal.
