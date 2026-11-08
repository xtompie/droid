d=.ai/droids/security
mkdir -p $d/inbox
printf 'name=security\ndescription=security droid\ncreated=2026-01-01\n' > $d/droid.ini
printf '# security\n\nKeeps security knowledge.\n\n## Responsible for\n- security\n\n## Not responsible for\n- other topics\n\n## Reads\n- nothing\n' > $d/droid.md
printf '# security\n\nUploads are limited to 20 requests per minute per user.\n' > $d/index.md
# Reply-To names a session that is not in the registry: the asking session is gone.
printf "From: session\nTo: security\nReply-To: session:%s\n\nWhat is the rate limit for uploads? Answer with the number.\n" 99999999-0000-4000-8000-000000000000 > $d/inbox/20260101-0900.upload-limit.md
