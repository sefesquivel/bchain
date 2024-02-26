// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract GradeContract {
    string public name;
    uint256 public prelimGrade;
    uint256 public midtermGrade;
    uint256 public finalGrade;
    string public gradeStatus;
    address public owner;

    event GradeComputed(string message, string name, string status);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier validGrade(uint256 _grade) {
        require(_grade >= 0 && _grade <= 100, "Grade must be between 0 and 100");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setName(string calldata _name) public {
        name = _name;
    }

    function setPrelimGrade(uint256 _prelimGrade) public onlyOwner validGrade(_prelimGrade) {
        prelimGrade = _prelimGrade;
    }

    function setMidtermGrade(uint256 _midtermGrade) public onlyOwner validGrade(_midtermGrade) {
        midtermGrade = _midtermGrade;
    }

    function setFinalGrade(uint256 _finalGrade) public onlyOwner validGrade(_finalGrade) {
        finalGrade = _finalGrade;
    }

    function calculateGrade() public onlyOwner { 
        uint256 totalGrade = (prelimGrade + midtermGrade + finalGrade) / 3;
        if (totalGrade >= 75) {
            gradeStatus = "Pass";
        } else {
            gradeStatus = "Fail";
        }
        emit GradeComputed("Grade calculated for ", name, gradeStatus);
    }
}
