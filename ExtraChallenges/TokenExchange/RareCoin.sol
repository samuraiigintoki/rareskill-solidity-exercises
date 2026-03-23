// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {SkillsCoin} from "ExtraChallenges/TokenExchange/SkillsCoin.sol";

contract RareCoin {
    SkillsCoin public skillsCoin;

    event RareCoin__Trade(address account, uint256 amount);

    mapping (address => uint256) public balanceOf;

    constructor (address _skillsCoinAddress) {
        skillsCoin = SkillsCoin(_skillsCoinAddress);
    }


    function trade(uint256 amount) external {
        require(amount > 0, "amount must not be Zero");

        uint256 balanceBefore = skillsCoin.balanceOf(address(this));

        skillsCoin.transferFrom(msg.sender, address(this), amount);

        uint256 balanceAfter = skillsCoin.balanceOf(address(this));
        require(balanceAfter - balanceBefore == amount, "transfer failed");

        balanceOf[msg.sender] += amount;

        emit RareCoin__Trade(msg.sender, amount);
    }

}