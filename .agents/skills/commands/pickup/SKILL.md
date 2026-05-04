---
name: pickup
description: Pick up a previous hunt session for a target. Loads hunt memory, last recon outputs, and notes so you resume with full context.
---

# $pickup

Resume a previous hunt for a target.

## When to Use

Use this at the start of a session if you already hunted the target before.
This reloads hunt memory, recon artifacts, and notes so you don't repeat work.

## Usage

```
$pickup target.com
```

## What It Does

1. Loads hunt-memory context for the target (patterns + audit log summary)
2. Reads last recon output in `recon/<target>/`
3. Pulls session notes if present
4. Surfaces the top 10 untested endpoints
5. Suggests where to pick up based on last known progress

## Output Example

```
RESUME: target.com
Last hunted: 2026-03-21
Tech stack: Next.js 14.2, GraphQL, Redis

Recent leads:
- /api/v2/export (200 without auth)
- /api/v1/users/{id}/teams (suspected IDOR)

Dead ends:
- /admin -> IP restricted (403)
- /api/v2/billing -> requires staff role

Suggested next move:
- Re-test /api/v1/users/{id}/teams with two accounts
- Check GraphQL mutation updateUserRole
```

## Tips

- After `pickup`, run `$hunt target.com --vuln-class idor` to continue with a focused pass.
- If recon data is old (> 7 days), re-run `$recon target.com` first.
