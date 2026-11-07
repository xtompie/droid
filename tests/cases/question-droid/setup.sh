for n in security docs; do
  d=.ai/droids/$n
  mkdir -p $d/inbox
  printf 'name=%s\ndescription=%s droid\ncreated=2026-01-01\n' $n $n > $d/droid.ini
  printf '# %s\n\nKeeps %s knowledge.\n\n## Responsible for\n- %s\n\n## Not responsible for\n- other topics\n\n## Reads\n- nothing\n' $n $n $n > $d/droid.md
  printf '# %s\n' $n > $d/index.md
done
printf 'From: docs\nTo: security\n\nAdd the new upload size limit to your rules.\n' > .ai/droids/security/inbox/20260101-0900.upload-limit.md
