// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//How to return multiple outputs
//name outputs
//Destructuring assignment

contract functionOutputs {
    
    function multiOutput() public pure returns (uint, bool) {
        return (2, true);
    }

    function namedOutput() public pure returns (uint a, bool b) {
        return (1, true);
    }

    function varAssigned() public pure returns (uint a, bool b) {
        a = 1;
        b = true;
    }

    //Destructuring example, calling the values from another function
    function destructAssigned() public {
        (uint a, bool b) = multiOutput();
        (, b) = multiOutput();
        // Log the values of a and b thru an event
        emit LogValues(a, b);

    }

        // Define an event to log the values
        event LogValues(uint a, bool _b);
    }



