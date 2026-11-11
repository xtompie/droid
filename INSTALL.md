# Installing Droid: instructions for an AI agent

You are an AI coding agent in the user's project. The user asked you to install Droid. Ask one question at a time and wait for the answer. Talk in the user's language.

## 1. Get the files

```bash
git clone --depth 1 https://github.com/xtompie/droid.git /tmp/droid-install
```

## 2. Ask

1. **Skills for this project or for your user?** Recommend project.
   - Project (recommended): skills go to `<project>/.claude/skills/`. Anyone who clones the repo gets them, so the droids folder makes sense to them.
   - User: skills go to `~/.claude/skills/`. Available in all your projects. User skills win over project skills with the same name, and they do not update when the repo does.
   Droids themselves always live in the project.
2. **Where to keep droids?** Suggest `.ai/droids`.
3. **Name prefix?** Suggest `droid` (skills `/droid-new`, `/droid-load`, ...).

## 3. Copy

Let `<dir>` be the droids folder and `<prefix>` the name prefix.

```bash
mkdir -p <dir>
cp /tmp/droid-install/core/droids.md <dir>/droids.md
cp -R /tmp/droid-install/skills/droid-* <skills-dir>/
```

- If `<dir>` is not `.ai/droids`, replace `.ai/droids` with `<dir>` in every copied `SKILL.md` and in `<dir>/droids.md`.
- If `<prefix>` is not `droid`, rename each skill folder (`droid-new` → `<prefix>-new`) and replace `droid-` with `<prefix>-` in the `name:` line and in every `/droid-` mention in all copied files.
- If skills already exist with these names, stop and ask.

## 4. Wire into the project

- Add `<dir>/*/session.ini` to the project `.gitignore`.
- If the project has a router or instruction file (`AGENTS.md` or `CLAUDE.md`), add one line: droids (list, loading, messages between droids) → `<dir>/droids.md`. Do not copy the rules there.

## 5. Check

```bash
ls <dir>
```

It should show only `droids.md`. Remove `/tmp/droid-install`.

## 6. Explain

Tell the user briefly:

- In a session that works on a topic, type `/<prefix>-new`. The session becomes a droid, named from the conversation.
- Later: `/<prefix>-load <name>` in any session, or `claude "/<prefix>-wake <name>"` to start a sleeping droid on its inbox. `/<prefix>-status` shows all droids.
- Other sessions hand work over in two ways: `/<prefix>-send` pings a running droid; a sleeping one gets the message in its inbox, and you get the command to start it. `/<prefix>-queue` leaves it in the inbox for later.

Ask whether to commit the installed files. Never push without being asked.

## Upgrading

When Droid is already installed (`<dir>/droids.md` exists):

1. Read the installed version from the line `Droid <version>.` at the top of `<dir>/droids.md`. No such line: it is 0.6.0 or older, so do every "Upgrade" step below; they are safe to repeat.
2. Get the files (step 1) and read `CHANGELOG.md`. Take every version newer than the installed one.
3. Copy `core/droids.md` and the skills again, as in step 3, with the same `<dir>` and `<prefix>` as before. Find them from the installed files: the folder that holds `droids.md` and the prefix of the installed skill folders. Remove installed skills that the repo no longer has.
4. Do the "Upgrade" steps of each newer version, oldest first.
5. Tell the user what changed, in a few lines, from the changelog. Ask whether to commit. Never push without being asked.
