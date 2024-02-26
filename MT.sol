// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MQuizContract {
    string public name;
    uint256 public age;
    uint256 public hrsWrk;
    uint256 public rate;
    uint256 public totSal;
    address public owner;

    event SalaryCalculated(string message, string name, uint256 totalSalary);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier validRate(uint256 _rate) {
        require(_rate > 0, "Rate must be greater than zero");
        _;
    }

    modifier validHrsWrk(uint256 _hrsWrk) {
        require(_hrsWrk > 0, "Hours worked must be greater than zero");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setName(string calldata _name) public {
        name = _name;
    }

    function setAge(uint256 _age) public {
        age = _age;
    }

    function setHrsWrk(uint256 _hrsWrk) public {
        hrsWrk = _hrsWrk;
    }

    function setRate(uint256 _rate) public onlyOwner validRate(_rate) {
        rate = _rate;
    }

    function calculateTotSal() public onlyOwner { 
        if (rate > 0 && hrsWrk > 0) {
            totSal = rate * hrsWrk;
            emit SalaryCalculated("Hello, ", name, totSal);
        } else {
            revert("Rate or hours worked is zero");
        }
    }
}
