---
name: droid-queue
description: Queue a message or a task for a droid, for later. Writes it to the droid's inbox only: no ping, no wake, even if the droid is running. The droid reads it next time it works. Use /droid-send instead when it is needed now.
argument-hint: "<to> <message>"
---

Paths are relative to the project root (`git rev-parse --show-toplevel`); write files with absolute paths.

1. `.ai/droids/<to>/droid.ini` must exist. If not, say so and stop.
2. Sender: the droid of this session (`.ai/droids/droids.md` → "Session file"), otherwise the person or "session".
3. Write the message so it makes sense on its own: what is needed, why, what to send back. A reply includes the question it answers.
4. File name: `date +%Y%m%d-%H%M`, then `.<slug>.md` with a short kebab-case slug. If the file exists, add `-2`, `-3`.
5. Write `.ai/droids/<to>/inbox/<file>`:
   ```
   From: <sender>
   To: <to>
   Reply-To: uds:<socket>

   <message>
   ```
   `Reply-To` only when the sender is not a droid (a plain session has no inbox): the socket is `echo "$CLAUDE_CODE_MESSAGING_SOCKET"`. A droid sender leaves the line out; its inbox is the address.
6. Nothing else: no ping, no wake, even if the droid is running. It reads the message next time it works (`/droid-work`, `/droid-load`) or when someone delivers a message with `/droid-send`.
7. Report in one line: the path, and that it waits in the inbox.
