---
name: token-scan
description: Scan a token contract for meme-coin rug pull patterns and critical on-chain vulnerabilities. Supports EVM and Solana.
---

# $token-scan

Scan a token contract for rug-pull patterns and critical vulnerabilities.

## Usage

```
$token-scan <contract-address>
$token-scan <contract.sol>         # local Solidity source
$token-scan <solana-address>
```

## What It Does

1. Detects mint/burn authority and owner privileges
2. Checks tax/fee mechanics, blacklist/whitelist logic
3. Detects LP lock status and liquidity removal risk
4. Checks for hidden transfer restrictions or anti-sell logic
5. Flags centralization risks and upgradeability

## Output Example

```
TOKEN SCAN: 0x1234...
═══════════════════════════════════════

CRITICAL:
- Owner can mint unlimited supply (rug risk)
- LP not locked and owner can remove liquidity

HIGH:
- Transfer blacklist function exists
- Max wallet/tx can be changed by owner

MEDIUM:
- Hidden fee switch for sell-only transactions

INFO:
- Proxy upgradeable (owner can swap implementation)
```

## EVM Checks

- `owner()` / `onlyOwner` modifiers
- `mint()` / `burn()` capability
- Blacklist mapping: `isBlacklisted[address]`
- Transfer hooks: `_beforeTokenTransfer` / `_afterTokenTransfer`
- Fee switches: `setTax`, `setFee`, `setSwapThreshold`
- LP lock: check Uniswap LP token status

## Solana Checks

- Mint authority
- Freeze authority
- Transfer restrictions
- Token metadata mutability
- LP and liquidity lock status (Raydium/Orca)

## Output Artifacts

- `token-scan/<address>/report.json`
- `token-scan/<address>/summary.md`

## What to Do Next

- If CRITICAL flags appear, treat as high risk or rug pull.
- For real audits, follow with `$web3-audit <contract.sol>`.
- If this is a bounty target, confirm scope first with `$scope`.
