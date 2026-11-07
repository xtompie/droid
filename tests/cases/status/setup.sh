for n in security docs; do
  d=.ai/droids/$n
  mkdir -p $d/inbox
  printf 'name=%s\ndescription=About %s\ncreated=2026-01-01\n' $n $n > $d/droid.ini
  printf '# %s\n' $n > $d/droid.md
  printf '# %s\n' $n > $d/index.md
done
printf 'From: session\nTo: security\n\nCheck the cookie flags.\n' > .ai/droids/security/inbox/20260101-0900.cookie-flags.md
