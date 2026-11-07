---
name: droid-send
description: Send a message or a task to a droid and get it done. Writes it to the droid's inbox, then pings the droid if its session is alive, or wakes it in the background if it is asleep. Use it whenever one droid or session needs another droid to do or answer something.
argument-hint: "<to> <message>"
---

1. Sender: the droid of this session (`.ai/droids/bin/droid whoami`), otherwise the person or "session".
2. Write the message so it makes sense on its own: what is needed, why, what to send back. A reply includes the question it answers.
3. Run `.ai/droids/bin/droid send <to> <sender> "<short slug>"` with the message on stdin.
4. If the output has `ping: uds:<socket>`, the droid is alive: send one SendMessage to that address with only "New message in inbox: <path>". Never put the content in the ping.
5. Otherwise the droid is asleep: wake it in the background from the project root and let it work through its inbox:
   `nohup claude -p "/droid-work <to> --background" --allowedTools "Bash(.ai/droids/bin/droid:*)" Read Write Edit Glob Grep SendMessage > /tmp/droid-<to>.out 2>&1 &`
6. Report in one line: the path, and whether the droid was pinged or woken.
