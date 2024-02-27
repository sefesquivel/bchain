// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Creating a contract
contract sampStorage
{
// Initialising array numbers
uint256[] public numbers;

// Function to insert values in the array numbers
function Numbers() public
{
	numbers.push(1);
	numbers.push(2);
	//Creating a new instance using storage or memory
	uint256[] storage myArray = numbers;
	
	// Adding value to the first index of the new Instance
	myArray[0] = 0;
} 
}
