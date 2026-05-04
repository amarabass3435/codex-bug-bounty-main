---
name: surface
description: Generate a ranked attack surface for a target from recon output and hunt memory. Uses recon-ranker agent to prioritize high-ROI endpoints.
---

# $surface

Rank a target's attack surface from recon data and hunt memory.

## Usage

```
$surface target.com
```

## What It Does

1. Reads `recon/<target>/` output
2. Loads hunt memory patterns relevant to the target and tech stack
3. Scores endpoints by vulnerability likelihood + impact
4. Produces a ranked list of endpoints and bug classes to test

## Output Example

```
ATTACK SURFACE: target.com
═══════════════════════════════════════

P1 (High ROI):
1. /api/v2/users/{id}/invoices     -> IDOR (missing ownership check)
2. /graphql                        -> Auth bypass on mutations
3. /api/v1/export                  -> Auth bypass (no auth header?)

P2 (Medium ROI):
4. /api/webhook                    -> SSRF candidate
5. /upload                         -> file upload restrictions
6. /redirect?next=                 -> open redirect (chain to OAuth?)

P3 (Low ROI):
7. /status                         -> info only
8. /docs                           -> likely excluded in scope
```

## Why This Matters

Most targets have thousands of endpoints. 80% of real bugs are found in 20% of the surface.
This command helps you hit the 20% first.

## Tips

- Use `$surface` right after `$recon`.
- Feed the top P1 endpoints into `$hunt target.com --vuln-class idor` or `$hunt target.com --vuln-class auth`.
- If you only have 1 hour, test the first 3 endpoints in P1.
