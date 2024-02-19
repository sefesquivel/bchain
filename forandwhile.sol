// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoopDemo {
    uint256[] public numbers;

    // Function to add numbers from 1 to n into an array using a for loop
    function addNumbersWithFor(uint256 n) external {
        for (uint256 i = 1; i <= n; i++) {
            numbers.push(i);
        }
    }

    // Function to add numbers from 1 to n into an array using a while loop
    function addNumbersWithWhile(uint256 n) external {
        uint256 i = 1;
        while (i <= n) {
            numbers.push(i);
            i++;
        }
    }

    // Function to calculate the sum of numbers in the array using a for loop
    function sumNumbersWithFor() external view returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }

    // Function to calculate the sum of numbers in the array using a while loop
    function sumNumbersWithWhile() external view returns (uint256) {
        uint256 sum = 0;
        uint256 i = 0;
        while (i < numbers.length) {
            sum += numbers[i];
            i++;
        }
        return sum;
    }
}
