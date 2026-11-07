---
name: droid-lint
description: Check and tidy a droid's wiki.
argument-hint: "[name]"
disable-model-invocation: true
---

Droid: the argument, or `.ai/droids/bin/droid whoami`. Run `.ai/droids/bin/droid is-bound <name>`; if it fails, stop and tell the user to run `/droid-load <name>`.

1. Lint the wiki (`droids.md` → "Wiki" → "Lint"): fix the mechanical issues, report the rest.
2. Report fixes and findings. Ask whether to commit.
