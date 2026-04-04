// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ReducingPayout {
    /*
        This exercise assumes you know how block.timestamp works.
        1. This contract has 1 ether in it, each second that goes by, 
           the amount that can be withdrawn by the caller goes from 100% to 0% as 24 hours passes.
        2. Implement your logic in `withdraw` function.
        Hint: 1 second deducts 0.0011574% from the current %.
    */

    // The time 1 ether was sent to this contract
    uint256 public constant DURATION = 24 hours;
    uint256 public immutable depositedTime;
    uint256 public initialBalance;

    constructor() payable {
        require(msg.value == 1 ether , "Must fund with 1 ETH");
        depositedTime = block.timestamp;
        initialBalance = address(this).balance;
    }

    function withdraw() public {
        // your code here
        uint256 elapsed = block.timestamp - depositedTime;

        require(elapsed >= DURATION, "No funds remaining to withdraw");

        uint256 remainingTime = DURATION - elapsed;
        uint256 amountToWithdraw = (initialBalance * remainingTime) / DURATION;

        (bool success,) = msg.sender.call{value: amountToWithdraw}("");
        require(success,"Tranfer failed");
    }
}
