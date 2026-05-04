---
name: web3-audit
description: Audit a Solidity contract for critical vulnerabilities. Uses 10 bug classes, Foundry PoC template, and pre-dive kill signals.
---

# $web3-audit

Audit a smart contract for security vulnerabilities.

## Usage

```
$web3-audit contract.sol
$web3-audit ./contracts/Vault.sol
$web3-audit ./src/*.sol          # batch
```

## What It Does

1. Identifies contract type and attack surface (token, vault, staking, proxy)
2. Scans for 10 critical bug classes
3. Generates Foundry PoC template
4. Produces a list of concrete attack scenarios

## Bug Classes Covered (10)

1. Reentrancy
2. Access control (missing onlyOwner, role misconfig)
3. Integer overflow / underflow
4. Price oracle manipulation
5. Flash loan attack paths
6. Token approval misuse
7. Upgradeability risks (proxy admin, init hijack)
8. Improper input validation
9. MEV / sandwich attack opportunities
10. Logic flaws (state machine bypass)

## Pre-Dive Kill Signals

If any of these are true, stop — likely a dead end:

- No external calls
- No privileged state changes
- No asset transfer logic
- All state changes gated by owner + timelock
- Contract is a wrapper around a well-audited library

## Output

```
Audit Summary: Vault.sol
Risk: HIGH

Findings:
[CRITICAL] Reentrancy in withdraw() allows balance drain
[HIGH] Missing access control on setTreasury()
[MEDIUM] Oracle price can be manipulated via DEX spot price

PoC:
- Foundry test file created at ./poc/Vault.t.sol
```

## Foundry PoC Template

```solidity
contract ExploitTest is Test {
  Vault vault;
  address attacker = address(0xBEEF);

  function setUp() public {
    vault = new Vault();
  }

  function testExploit() public {
    vm.startPrank(attacker);
    // exploit steps
    vm.stopPrank();
  }
}
```

## Notes

- Prefer confirming the exploit in a forked mainnet environment.
- Quantify loss in $ when reporting to Immunefi.
