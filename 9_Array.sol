// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MidtermArray {
    uint[] public arr = [1, 2, 3, 4, 5];
    uint[] public arr2 = [1, 2, 3, 4, 5];
    uint[10] public myFixedSizeArr;

     function get(uint i) public view returns (uint) {
        return arr[i];
    }

     function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function push(uint i) public {
        arr.push(i);
    }
    
    function pop() public {
        arr.pop();
    }

    function remove(uint index) public {
        delete arr[index];
    }

    function remove2(uint index) public {
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
     function getLength() public view returns (uint) {
        return myFixedSizeArr.length;
    }

}


