---
name: droid-send
description: Send a droid a message or task and get it done now. Writes it to the droid's inbox, then pings the droid if its session is alive, or wakes it in the background if it is asleep. Use it when the answer or the work is needed now, and for every answer or question to a sender who waits.
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
6. Read `.ai/droids/<to>/session.ini` if it exists. If `ps -p <pid>` succeeds, the droid is alive: send one SendMessage to `uds:<socket>` with only "New message in inbox: <path>". Never put the content in the ping.
7. Otherwise the droid is asleep: wake it in the background from the project root and let it work through its inbox:
   ```bash
   nohup claude -p "/droid-work <to> --background" --allowedTools Read Write Edit Glob Grep SendMessage "Bash(echo:*)" "Bash(ps:*)" "Bash(ls:*)" "Bash(date:*)" "Bash(mkdir:*)" "Bash(rm:*)" > /tmp/droid-<to>.out 2>&1 &
   ```
8. Report in one line: the path, and whether the droid was pinged or woken.
