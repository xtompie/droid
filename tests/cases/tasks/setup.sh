d=.ai/droids/security
mkdir -p $d/inbox
printf 'name=security\ndescription=Security rules and dependency risks\ncreated=2026-01-01\n' > $d/droid.ini
printf '# security\n' > $d/droid.md
printf '# security\n' > $d/index.md
printf 'From: session\nTo: security\n\nRotate the API signing keys.\n' > $d/inbox/20260101-0900.rotate-keys.md
printf 'From: docs\nTo: security\n\nReview the new login flow.\n' > $d/inbox/20260102-1000.review-login.md
