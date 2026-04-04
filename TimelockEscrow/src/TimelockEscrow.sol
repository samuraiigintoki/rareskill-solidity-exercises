// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;
    uint256 public constant THREE_DAYS = 3 days;


    mapping(address => Escrow) public escrows;

    struct Escrow {
        uint256 amount;
        uint256 startTime;
        bool active;
    }
    

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    
    /**
     * creates a buy order between msg.sender and seller
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        // your code here
        Escrow storage userEscrow = escrows[msg.sender];

        require(msg.value > 0, "Must not be zero");
        
        userEscrow.amount = msg.value;
        userEscrow.startTime = block.timestamp;
        userEscrow.active = true;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        // your code here
        require(msg.sender == seller,"Not authorized");
     
        Escrow storage userEscrow = escrows[buyer];
        require(block.timestamp >= userEscrow.startTime + THREE_DAYS , "Not enough time passed");

        uint256 amount = userEscrow.amount;

        userEscrow.amount = 0;
        userEscrow.active = false;
        
        (bool success,) = seller.call{value: amount}("");
        require(success, "transfer Failed");
        
    }

    /**
     * allows buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        // your code here
        Escrow storage userEscrow = escrows[msg.sender];
        require(userEscrow.active == true , "Escrow period over");
        require(block.timestamp < userEscrow.startTime + THREE_DAYS, "escrow period ended ");

        uint256 amount = userEscrow.amount;

        userEscrow.amount = 0;
        userEscrow.active = false;

        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "transfer failed");
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        // your code here
        return escrows[buyer].amount;
    }
}
