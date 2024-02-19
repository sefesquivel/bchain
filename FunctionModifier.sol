// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunctionModifiersExample {
    address public owner;
    uint256 public someValue;
    bool public isLocked;

    // Modifier to restrict access to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _; // This indicates that the function's code will be executed after the modifier
    }

    // Modifier to check if the contract is not locked
    modifier notLocked() {
        require(!isLocked, "Contract is currently locked");
        _; // This indicates that the function's code will be executed after the modifier
    }

    // Constructor sets the deployer's address as the owner
    constructor() {
        owner = msg.sender;
    }

    // Function to set the value, only callable by the owner and when the contract is not locked
    function setSomeValue(uint256 newValue) external onlyOwner notLocked {
        someValue = newValue;
    }

    // Function to lock the contract, only callable by the owner
    function lockContract() external onlyOwner {
        isLocked = true;
    }

    // Function to unlock the contract, only callable by the owner
    function unlockContract() external onlyOwner {
        isLocked = false;
    }
}
