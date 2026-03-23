// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract SkillsCoin{
    
    mapping(address user => uint256 balance) public balanceOf;
    mapping(address owner => mapping(address spender=> uint256 allowed)) public allowance;

    function mint(uint256 amount) external {
        balanceOf[msg.sender] += amount;
    }

    function approve(address spender, uint256 amount) external {
        allowance[msg.sender][spender] = amount;
    }

    function transferFrom(address from , address to , uint256 amount) external {
        require(balanceOf[from] >= amount, "not enough tokens");
        require(allowance[from][msg.sender] >=amount,"allowance too low");

        allowance[from][msg.sender] -= amount;

        balanceOf[from] -= amount;
        balanceOf[to] += amount;
    
    }
}