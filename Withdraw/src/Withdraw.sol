// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Withdraw {
    // @notice make this contract able to receive ether from anyone and anyone can call withdraw below to withdraw all ether from it
    function withdraw() public {
        // your code here
        (bool success,) = msg.sender.call{value:address(this).balance}("");
        require(success, "transfer failed");
    }

    receive() external payable{}
}
