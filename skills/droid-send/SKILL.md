---
name: droid-send
description: Send a droid a message or task now. Writes it to the droid's inbox and pings the droid if its session is running. A sleeping droid finds it in its inbox, and you get the command to start it. Use it when the answer or the work is needed now, and for every answer or question to a sender who waits.
argument-hint: "<to> <message>"
---

Paths are relative to the project root (`git rev-parse --show-toplevel`); write files with absolute paths.

1. `.ai/droids/<to>/droid.ini` must exist. If not, say so and stop.
2. Sender: the droid of this session, the one whose `session.ini` has `session=${CLAUDE_SESSION_ID}` (`.ai/droids/droids.md` → "Session file"), otherwise the person or "session".
3. Write the message so it makes sense on its own: what is needed, why, what to send back. A reply includes the question it answers.
4. File name: `date +%Y%m%d-%H%M`, then `.<slug>.md` with a short kebab-case slug. If the file exists, add `-2`, `-3`.
5. Write `.ai/droids/<to>/inbox/<file>`:
   ```
   From: <sender>
   To: <to>
   Reply-To: session:<id>

   <message>
   ```
   `Reply-To` only when the sender is not a droid (a plain session has no inbox): the id is `${CLAUDE_SESSION_ID}`. A droid sender leaves the line out; its inbox is the address.
6. Read `session=` from `.ai/droids/<to>/session.ini` if it exists. That is the recipient droid's session id, not yours. Look up that id (`.ai/droids/droids.md` → "Session file"). Alive: send one SendMessage to its ping address with only "New message in inbox: <path>". Never put the content in the ping.
7. No `session.ini`, the lookup says asleep, or the ping failed: the droid is asleep. Start nothing. The message waits in its inbox.
8. Report in the user's language, plainly, one thing per line. Use the path relative to the project root.
   - Pinged:
     ```
     Message sent to <to>: <path>
     ```
   - Asleep:
     ```
     <to> is asleep, so it cannot be reached now.
     The message is saved in its inbox: <path>
     To have it handled now, run in a new terminal:
     claude "/droid-wake <to> <path>"
     ```
   This is a normal outcome, not an error. Do not call it a block or a failure.
