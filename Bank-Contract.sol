// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.6;

/**
 * @title Bank Contract
 * @dev Frankiefab100
 */
 
contract Bank{
    mapping (address => uint)
    private balances;
    address public owners;
    event LogDepositMade (address accountAddress, uint amount);

    constructor() public {
        owners = msg.sender;
    }

    function deposit() public payable returns (uint){
        require ((balances[msg.sender] + msg.value) >= balances[msg.sender]);
        balances [msg.sender] += msg.value;
        emit LogDepositMade (msg.sender, msg.value);
        return balances[msg.sender];
    }

    function Withdraw(uint withdrawAmount) public returns (uint remainingBal){
        require(withdrawAmount <= balances[msg.sender]);
        balances[msg.sender] -= withdrawAmount;
        msg.sender.transfer(withdrawAmount);
        return balances [msg.sender];
    }

    function balance() view public returns (uint){
        return balances[msg.sender];
    }

}
