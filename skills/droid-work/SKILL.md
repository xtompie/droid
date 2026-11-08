---
name: droid-work
description: Make the droid work through its inbox, one item at a time, until it is empty or the user is needed.
argument-hint: "[name] [--background]"
disable-model-invocation: true
---

Droid: the argument, or the droid of this session (`.ai/droids/droids.md` → "Session file"). Check that this session is the droid: `echo "$CLAUDE_CODE_SESSION_ID"` equals `session=` in its `session.ini`. If not, stop and tell the user to run `/droid-load <name>`.

`--background` (used only when `/droid-send` wakes an asleep droid in a headless run): instead of the check, write `session.ini` with only `session=<own session id>` (`droids.md` → "Session file") unless it points to another session that the lookup finds alive (then stop), and read `droids.md`, the droid's `droid.md` and `index.md`. Never ask the user; questions go to the sender (step 4). At the end make sure the knowledge is in the wiki and `index.md` lists every page. Do not commit.

Repeat:
1. `ls .ai/droids/<name>/inbox`. Empty → say so and stop.
2. Pick the item that matters most now (the inbox is unordered; urgency is in the body). Skip files with a `Waiting for:` line unless a newer message answers them; then take that pair together. Skip files with an `Undelivered:` line: they wait for someone to read the answer.
3. Do it. Read wiki pages and project docs as needed.
4. If you cannot do it without an answer, ask the sender (`droids.md` → "Questions"), append `Waiting for: <question>` to the inbox file, and go to the next item.
5. If the sender expects an answer, reply with the question and the answer, self-contained: to a droid with `/droid-send <sender> <message>`, to a session by looking up its `Reply-To: session:<id>` (`droids.md` → "Session file") and SendMessage to its ping address. If the session is not alive (the lookup says asleep, or SendMessage fails), append `Undelivered:` and the answer to the inbox file, keep the file and go to step 6.
6. Fold new knowledge into the wiki (`droids.md` → "Wiki").
7. Delete the processed inbox file, and the answer that unblocked it: `rm .ai/droids/<name>/inbox/<file>`. Keep a file with `Undelivered:`.
