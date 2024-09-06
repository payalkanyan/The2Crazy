// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuyAndSell {
    address public owner;
    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
    }

    function buy(uint256 _amount) external payable {
        require(msg.value >= _amount, "Insufficient funds");
        balances[msg.sender] += _amount;
    }

    function sell(uint256 _amount) external {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }
}
