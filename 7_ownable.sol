// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Ownable {

    address public owner;
constructor() {
    owner = msg.sender;
}

modifier onlyOwner() {
    require(msg.sender == owner, "not owner");
    _;
}


function setOwner(address newOwner) external onlyOwner {
    require( newOwner != address(0), "invalid address");
    owner = newOwner;
}

function onlyOwnerCanCallThisFunction() external onlyOwner {

}

function anyOneCanCallThisFunction() external {

}

}
