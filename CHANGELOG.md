# Changelog

Every installed project has its version in `<droids dir>/VERSION`. To upgrade, see "Upgrading" in `INSTALL.md`.

## 0.7.0

- `/droid-send` no longer wakes a sleeping droid in the background. The message waits in its inbox, and the sender gets the command to start it: `claude "/droid-wake <name> <inbox file>"`, said plainly, one thing per line.
- New `/droid-wake <name> [inbox file]`: loads the droid in this session and works through its inbox, the given message first.
- `/droid-work` has no `--background` mode.
- Skills take the session id from Claude Code (`${CLAUDE_SESSION_ID}`) and leave permissions to the user.
- Requires Claude Code 2.1.310 or newer.

Upgrade: install the new `droid-wake` skill. Add `<droids dir>/VERSION`.

## 0.6.0

- Live sessions are found in Claude Code's session registry (`~/.claude/sessions/`). `session.ini` keeps only `session=`, so a resumed session stays loaded and gets pings.
- `Reply-To` of a plain session is `session:<id>`.

Upgrade: in every `<droids dir>/*/session.ini`, keep only the `session=` line.

## 0.5.0

- An answer that cannot be delivered (the asking session is gone) stays in the inbox with `Undelivered:`. `/droid-tasks` and `/droid-status` show it.

## 0.4.0

- `/droid-send` delivers now (ping, or wake if asleep). New `/droid-queue` only writes to the inbox. `/droid-call` is gone.

Upgrade: remove the `droid-call` skill. Old `/droid-send` (inbox only) is now `/droid-queue`.

## 0.3.0

- `/droid-send` (inbox only) and `/droid-call` (deliver now).

## 0.2.0

- Live tests for every skill.
- A droid asks whoever sent the message; a task waiting for an answer gets `Waiting for:`.
- `/droid-new` writes exact templates and does not look at other droids.

## 0.1.0

- First release: droids with a wiki and an inbox, skills as plain step-by-step instructions.
