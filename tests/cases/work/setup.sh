d=.ai/droids/security
mkdir -p $d/inbox
printf 'name=security\ndescription=Security rules and dependency risks\ncreated=2026-01-01\n' > $d/droid.ini
printf '# security\n\nKeeps security rules.\n\n## Responsible for\n- security rules\n\n## Not responsible for\n- docs\n\n## Reads\n- nothing\n' > $d/droid.md
printf '# security\n' > $d/index.md
printf 'From: session\nTo: security\n\nRecord this rule in your wiki: uploads above 10 MB are rejected. No reply needed.\n' > $d/inbox/20260101-0900.upload-limit.md
