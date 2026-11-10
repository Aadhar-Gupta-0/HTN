# HTN — Capped ERC-20 Token Lab

A Hardhat 3 / Viem smart-contract workshop with a **real ERC-20 implementation**, explicit owner controls, a supply cap, and safer, configurable deployment scripts.

## Improvements
- OpenZeppelin ERC-20 rather than an empty Token placeholder.
- Initial supply minted to an explicit deployer owner on construction.
- Owner-only mint operation that cannot exceed an immutable supply cap.
- Ignition module parameters for supply and cap.
- Mint script reads target and recipient addresses from environment variables and validates them.

## Local verification
\`\`\`bash
npm ci
npm run build
\`\`\`

## Development
Run the Hardhat local simulation before connecting a testnet. \`npm run deploy\` targets Sepolia and can spend testnet ETH; do not run without reviewing parameters, network, and accounts. Never commit private keys.

## Safety
**Educational smart contracts, not audited.** No real funds or production token launches until independent audit, test coverage, deployment scripts, and access controls have been reviewed.

This edition builds on the Hardhat workshop starter from [ethglobal/htn2025](https://github.com/ethglobal/htn2025), independently maintained as \`Aadhar-Gupta-0/HTN\`.
