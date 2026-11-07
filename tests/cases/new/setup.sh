d=.ai/droids/docs
mkdir -p $d/inbox
printf 'name=docs\ndescription=Keeps the documentation consistent\ncreated=2026-01-01\n' > $d/droid.ini
printf '# docs\n\nZEBRA-MARKER-7 keeps the docs consistent.\n\n## Responsible for\n- ZEBRA-MARKER-7 documentation\n' > $d/droid.md
printf '# docs\n' > $d/index.md
