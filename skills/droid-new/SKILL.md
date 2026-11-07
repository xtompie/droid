---
name: droid-new
description: Create a new droid, a persistent worker for one topic, and load it into this session. Without arguments, take the name and description from the current conversation.
argument-hint: "[name] [what it does]"
disable-model-invocation: true
---

Read `.ai/droids/droids.md` first.

1. Name and description: use the arguments if given. Otherwise infer from this conversation what it is about: a short kebab-case name (1–3 words) and one sentence for the description.
2. Run `.ai/droids/bin/droid status`. If the name is taken, pick another and say so.
3. Run `.ai/droids/bin/droid new <name> "<description>"`.
4. Fill `droid.md` (responsible for, not responsible for, which project docs it reads) from this conversation. Knowledge already worked out in this conversation goes into wiki pages and `index.md` (`droids.md` → "Wiki").
5. Run `.ai/droids/bin/droid load <name>`.
6. Say in one sentence who this droid is and what it does. From now on, act as this droid.
