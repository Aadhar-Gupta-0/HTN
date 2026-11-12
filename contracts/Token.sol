// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

/**
 * @title NorthToken
 * @notice Capped ERC-20 demo with two-step owner transfers and emergency pausing for hackathon experiments.
 * @dev Not audited. Never deploy with real-value assets without external review.
 */
contract Token is ERC20, ERC20Pausable, Ownable2Step {
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

    /**
     * @notice Freeze token transfers and minting in an emergency.
     * @dev Owner can restore transferability once the issue is resolved.
     */
    function pause() external onlyOwner { _pause(); }

    function unpause() external onlyOwner { _unpause(); }

    function _update(address from, address to, uint256 value)
        internal override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        if (amount > cap - totalSupply()) revert CapExceeded();
        _mint(to, amount);
    }
}
