---
name: droid-load
description: Load a droid into this session. Use it when starting or resuming a session as a droid, and when pings to the droid stop arriving.
argument-hint: "<name>"
disable-model-invocation: true
---

1. `.ai/droids/<name>/droid.ini` must exist. If not, say so and stop.
2. Own values: `echo "$CLAUDE_CODE_SESSION_ID $CLAUDE_PID $CLAUDE_CODE_MESSAGING_SOCKET"`.
3. If `.ai/droids/<name>/session.ini` exists, its `session=` is another session and `ps -p <its pid>` succeeds: the droid is loaded in another live session. Ask the user once: take it over in this session? On no, stop.
4. Write `.ai/droids/<name>/session.ini`:
   ```ini
   session=<own session id>
   pid=<own pid>
   socket=<own socket>
   ```
5. Read `.ai/droids/droids.md`, then the droid's `droid.md` and `index.md`. Do not read all pages; open them when a task needs them.
6. `ls .ai/droids/<name>/inbox`.
7. Say in two sentences who you are now and what is in the inbox. From now on, act as this droid.
