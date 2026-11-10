// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title NorthToken
 * @notice Capped ERC-20 demo token with owner-managed minting for hackathon experiments.
 * @dev Not audited. Never deploy with real-value assets without external review.
 */
contract Token is ERC20, Ownable {
    uint256 public immutable cap;

    error CapExceeded();
    error InvalidCap();

    constructor(address initialOwner, uint256 initialSupply, uint256 maxSupply)
        ERC20("North Token", "NORTH")
        Ownable(initialOwner)
    {
        if (maxSupply == 0 || initialSupply > maxSupply) revert InvalidCap();
        cap = maxSupply;
        _mint(initialOwner, initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        if (amount > cap - totalSupply()) revert CapExceeded();
        _mint(to, amount);
    }
}
