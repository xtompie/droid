---
name: droid-work
description: Make the droid work through its inbox, one item at a time, until it is empty or the user is needed.
argument-hint: "[name] [--background]"
disable-model-invocation: true
---

Droid: the argument, or the droid of this session (`.ai/droids/droids.md` → "Session file"). Check that this session is the droid: `echo "$CLAUDE_CODE_SESSION_ID"` equals `session=` in its `session.ini`. If not, stop and tell the user to run `/droid-load <name>`.

`--background` (used only when `/droid-send` wakes an asleep droid in a headless run): instead of the check, write `session.ini` with the own values (`droids.md` → "Session file") unless it points to another live session (then stop), and read `droids.md`, the droid's `droid.md` and `index.md`. Never ask the user; anything that needs a decision goes as a message to the sender. At the end make sure the knowledge is in the wiki and `index.md` lists every page. Do not commit.

Repeat:
1. `ls .ai/droids/<name>/inbox`. Empty → say so and stop.
2. Pick the item that matters most now (the inbox is unordered; urgency is in the body).
3. Do it. Read wiki pages and project docs as needed.
4. If the sender expects an answer, reply with `/droid-send <sender> <message>`: the question and the answer, self-contained.
5. Fold new knowledge into the wiki (`droids.md` → "Wiki").
6. Delete the processed inbox file: `rm .ai/droids/<name>/inbox/<file>`.
7. If you need the user's decision, ask it and stop.
