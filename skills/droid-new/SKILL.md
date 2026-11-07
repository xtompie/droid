---
name: droid-new
description: Create a new droid, a persistent worker for one topic, and load it into this session. Without arguments, take the name and description from the current conversation.
argument-hint: "[name] [what it does]"
disable-model-invocation: true
---

Read `.ai/droids/droids.md` first.

1. Name and description: use the arguments if given. Otherwise infer from this conversation what it is about: a short kebab-case name (1–3 words) and one sentence for the description. The name is an ongoing responsibility, not a task.
2. `ls .ai/droids`. If a folder with that name exists, pick another and say so.
3. `date +%Y-%m-%d` for the creation date. Create:
   - `.ai/droids/<name>/droid.ini`:
     ```ini
     name=<name>
     description=<one sentence>
     created=<date>
     ```
   - `.ai/droids/<name>/droid.md`: who it is, responsible for, not responsible for, which project docs it reads. Fill it from this conversation.
   - `.ai/droids/<name>/index.md`: `# <name>` and the wiki catalog. Knowledge already worked out in this conversation goes into wiki pages listed here (`droids.md` → "Wiki").
   - `mkdir -p .ai/droids/<name>/inbox`
4. Load it: do the steps of `/droid-load <name>` (this session takes it).
5. Say in one sentence who this droid is and what it does. From now on, act as this droid.
