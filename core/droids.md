# Droids

A droid is a persistent worker for one topic. Instead of making sure every session loads the right
documents, you set up a droid that looks after its own context: it keeps its knowledge, decisions
and notes with itself, as a small wiki. It does not expose them to others. Other sessions do not
read its files; they write to its inbox or hand it a task. A droid works even when nobody is
talking to it: messages wait in its inbox, and the droid can be woken in a separate session, in the
background, or in the current one. Everything is plain files in git, so several people can work
with droids the same way they work with code.

The main session's context stays clean. Work on a topic happens in the droid's own context, scoped
to the task. Whoever asks gets the result, not the reading that led to it. It is like a subagent,
but persistent: it keeps what it learned for the next task.

A session is the base layer. A droid is loaded into a session on purpose, with `/droid-load`.
Nothing turns a session into a droid by itself.

## Layout

All paths are relative to the project root. Before writing a file, resolve it to an absolute path from `git rev-parse --show-toplevel`.


```
<droids-dir>/
  droids.md          this file
  <name>/
    droid.ini        name, description, created
    droid.md         who it is: responsible for, not responsible for, which project docs it reads
    session.ini      session, pid, socket of the session that loaded it (not in git)
    inbox/           one message or task per file
    index.md         catalog of its wiki pages
    sources.md       optional: where to look when researching its topic
    <page>.md        wiki pages, flat
```

- The droid keeps the knowledge of its topic in its wiki. Nowhere else.
- Continuity comes from the wiki and the inbox. There is no separate state file. If the droid wants
  to remember what it is working on, that is just another wiki page.
- Content (pages, messages) is written in the language the user speaks. File names: English, kebab-case.
- No log and no history sections. Git history is the history.
- A droid is an ongoing responsibility, not a task with an end: `security`, `docs`, `database`.
- Names: kebab-case, lowercase letters, digits and dashes (`security`, `docs-site`).

## Session file

`<name>/session.ini` says which session the droid is loaded in. It is not in git.

```ini
session=8f3c2a10-5b7e-4c1d-9a2f-0d6e4b8a7c21
pid=43440
socket=/tmp/cc-socks/43440.sock
```

- Own values: `echo "$CLAUDE_CODE_SESSION_ID $CLAUDE_PID $CLAUDE_CODE_MESSAGING_SOCKET"`.
- Is that session alive: `ps -p <pid>` (exit code 0 = alive).
- Which droid this session is: the droid whose `session.ini` has `session=` equal to the own session id. Find it with Grep over `<droids-dir>/*/session.ini`.
- Inbox count: `ls <droids-dir>/<name>/inbox`.

## Session

- `/droid-load <name>` writes `session.ini` with the current session id, pid and messaging socket. The last load wins.
- A resumed session gets a new pid and socket. Run `/droid-load` again in it if pings stop arriving.
- Skills that write into a droid (`droid-work`, `droid-save`, `droid-lint`) first check that this
  session is the droid (its `session.ini` has `session=` equal to the own session id). If not, they stop and ask for `/droid-load`.
- No ownership, no locks. Two people working on one droid is a team communication matter, solved
  the same way as two people editing one module: git shows the conflict.

## Messages

- A message is always a file: `inbox/YYYYMMDD-HHMM.<slug>.md`, first lines `From: <droid or person>` and `To: <droid>`, then the body.
- The inbox is unordered. The droid picks what matters most, like a person reading mail. Its own tasks go to its inbox too.
- If the recipient's session is alive, the sender also sends a ping to `uds:<socket>`: "New message in inbox: <path>". The ping carries no content, so a lost ping loses nothing.
- A droid that gets a ping finishes its current step, then takes the inbox. Urgency is stated in the message body.
- A reply contains the question and the answer, so it makes sense on its own. Several replies are fine ("started", "done, result here").
- A processed message is deleted. What it changed lives in the wiki.

## Wiki

Based on Karpathy's LLM Wiki pattern, one topic per droid.

**Page format:**

```markdown
---
title: Auth rules
updated: 2026-11-07
sources:
  - "[Source title](https://example.com/a) — 2026-04-01 — high"
---

# Auth rules

> 2–4 sentence summary: the answer a busy reader needs.

## <body sections>

## How to apply

## See also
- [Other page](other-page.md) — why it is related
```

- **Concept page:** one concept, technique, tool, decision area. **Process page:** end-to-end steps for a task the droid does ("how we review a change that touches login"), built from concept pages.
- One concept per page. Name the file after the concept.
- `sources` entries: `"[title](url or path) — date or unknown — high|medium|low"`. Pages built from work (not external sources) may list the message or page they come from.
- Links: standard Markdown, relative paths. No `[[wikilinks]]`, no absolute paths.
- Do not invent facts. Write numbers and quotes exactly as found.
- Keep a page under ~300 lines. Split when it grows past that.
- A claim that is replaced or contradicted stays, marked directly below it:

```markdown
> **Status: Outdated** (2026-11-07) — what replaced it, with source.
> **Status: Disputed** — the competing claims, each with source.
```

**`index.md`:** every page has one line: `- [Title](page.md) — one-line summary`, grouped under `## Processes` and other headings. A page without an index line does not exist.

**Folding new knowledge in** (after a task, a message or research): grep the wiki for its key concepts, then decide and state it in one line:
- **New:** create page(s).
- **Update:** merge into existing page(s).
- **Disputed:** mark with a Status block.
- **Nothing new:** write nothing.

Then update `index.md`. If the change alters how a task is done, update its process page.

**Lint:**
- Fix: pages missing from `index.md`, index lines pointing at missing files, broken links with an unambiguous target.
- Report: contradictions, claims without a source, stale pages, orphan pages, two pages on the same concept, tasks with concept pages but no process page.

## Skills

| Skill | Does |
|---|---|
| `/droid-new [name] [what it does]` | new droid; without arguments, name and description come from the current conversation; loads it into this session |
| `/droid-clone <source> [name] [how it differs]` | new droid from another: same role and wiki, fresh inbox |
| `/droid-status` | all droids: tasks, session, description |
| `/droid-load <name>` | load a droid into this session; also when pings stop arriving |
| `/droid-tasks [name]` | list the inbox, change nothing |
| `/droid-work [name]` | work through the inbox |
| `/droid-send <to> <message>` | write a message to a droid's inbox, then ping it if alive or wake it in the background if asleep |
| `/droid-save [name]` | fold missing knowledge into the wiki, light lint |
| `/droid-lint [name]` | full wiki lint |
| `/droid-destroy <name>` | remove a droid |

`[name]` is optional in a session that already is a droid.
