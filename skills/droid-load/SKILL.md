---
name: droid-load
description: Load a droid into this session. Use it when starting or resuming a session as a droid, and when pings to the droid stop arriving.
argument-hint: "<name>"
disable-model-invocation: true
---

1. Run `.ai/droids/.bin/droid load <name>`.
   - Exit 3 (`busy`): the droid is loaded in another live session. Ask the user once: take it over in this session? On yes run `.ai/droids/.bin/droid load <name> --force`. On no, stop.
2. Read `.ai/droids/droids.md`, then the droid's `droid.md` and `index.md`. Do not read all pages; open them when a task needs them.
3. Run `.ai/droids/.bin/droid tasks <name>`.
4. Say in two sentences who you are now and what is in the inbox. From now on, act as this droid.
