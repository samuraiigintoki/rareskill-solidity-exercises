// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IsSorted {
    /**
     * The goal of this exercise is to return true if the members of "arr" is sorted (in ascending order) or false if its not.
     */
    function isSorted(uint256[] calldata arr) public view returns (bool) {

        if(arr.length <= 1) {
            return true;
        }

        if(arr.length == 2) {
            if(arr[0] > arr[1]){
                return false;
            }else {
                return true;
            }
        }        

        for(uint256 i = 0 ; i < arr.length-2 ; i++) {

            if ( arr[i] > arr[i+1] ) {
                return false;
            }

        }
        return true ;
    }
}
