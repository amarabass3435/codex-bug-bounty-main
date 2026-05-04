# Codex Bug Bounty

## Working agreements

- Prefer the Codex CLI and Codex skill invocation over legacy slash commands.
- Keep one target per session to avoid cross-contamination.
- Use the recon outputs under recon/<target>/ before running live tests.
- Store findings under findings/<target>/ and reports under reports/.
- Treat tools in tools/ as the source of truth for execution steps.

## Safety

- Do not run destructive commands unless explicitly asked.
- Keep scoped targets in-scope only and stop if scope is unclear.
