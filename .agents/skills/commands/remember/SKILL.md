---
name: remember
description: Log a confirmed finding pattern to hunt memory so future hunts learn from it. Updates pattern DB with exact endpoints, payloads, and response signatures.
---

# $remember

Store a confirmed pattern for future hunts.

## When to Use

After you confirm a real bug or a strong signal you want to reuse later.

## Usage

```
$remember
```

When prompted, include:

- Target and program
- Bug class
- Endpoint pattern
- Payload or request shape
- Response signature (e.g., error code, JSON field, header)
- Why it worked (missing auth check, unsafe deserialization, etc.)

## What It Does

- Appends a normalized pattern entry to `hunt-memory/patterns.jsonl`
- Updates pattern statistics (hit rate, last seen)
- Makes that pattern available to recon-ranker and autopilot

## Example Entry

```
Target: target.com
Bug class: IDOR
Endpoint pattern: /api/v2/users/{id}/invoices
Payload: Replace {id} with victim user_id
Response signature: 200 with {"invoice_id":..., "amount":...}
Root cause: missing ownership check on invoice retrieval
Notes: Works on v2 but v1 is fixed
```

## Output

**Saved:** "Pattern added: IDOR /api/v2/users/{id}/invoices (hit-rate 1/1)"

**Skip:** "Pattern already exists with stronger evidence. No update needed."

## Tips

- Prefer patterns with strong signals (exact endpoint, exact response signature)
- Don't save generic notes like "test for IDOR" — they create noise
- If you only have a weak lead, store it in session notes instead
