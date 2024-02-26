// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MQuizContract {
    string public name;
    uint256 public age;
    uint256 public hrsWrk;
    uint256 public rate;
    uint256 public totSal;

    event SalaryCalculated(string message, string name, uint256 totalSalary);

    function setName(string calldata _name) public {
        name = _name;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function setAge(uint256 _age) public {
        age = _age;
    }

    function getAge() public view returns (uint256) {
        return age;
    }

    function setHrsWrk(uint256 _hrsWrk) public {
        hrsWrk = _hrsWrk;
    }

    function getHrsWrk() public view returns (uint256) {
        return hrsWrk;
    }

    function setRate(uint256 _rate) public {
        rate = _rate;
    }

    function getRate() public view returns (uint256) {
        return rate;
    }

    function calculateTotSal() public { 
        totSal = rate * hrsWrk;
        emit SalaryCalculated("Hello, " , name, totSal);
    }

    function getTotSal() public view returns (uint256) {
        return totSal;
    }
}
