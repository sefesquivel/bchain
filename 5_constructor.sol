// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MappingExample {
    mapping(address => uint256) public valueMapping;

    // Modifier to check if the value being set is not zero
    modifier nonZeroValue(uint256 _value) {
        require(_value != 0, "Value cannot be zero");
        _;
    }

    // Modifier to check if there's a value set for the sender
    modifier valueHasBeenSet() {
        require(valueMapping[msg.sender] != 0, "No value set for sender");
        _;
    }

    // Constructor to initialize the contract
    constructor() {
        // Example, this will initialize a default value for the contract creator
        valueMapping[msg.sender] = 100;
    }

    // Function to set a value for the sender's address
    function setValue(uint256 _value) public nonZeroValue(_value) {
        // Check if the value being set is greater than the current value
        if (_value > valueMapping[msg.sender]) {
            valueMapping[msg.sender] = _value;
        }
    }

    // Function to retrieve the value associated with the sender's address
    function getValue() public view valueHasBeenSet returns (uint256) {
        return valueMapping[msg.sender];
    }
}
