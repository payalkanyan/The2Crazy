// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Staking {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public unstakingTimes;

    function stake(uint256 _amount) external payable {
        require(msg.value >= _amount, "Insufficient funds");
        stakes[msg.sender] += _amount;
    }

    function unstake(uint256 _amount) external {
        require(stakes[msg.sender] >= _amount, "Insufficient stake");
        stakes[msg.sender] -= _amount;
        unstakingTimes[msg.sender] = block.timestamp + 30 days; // 30-day cooldown period
    }

    function withdraw() external {
        require(unstakingTimes[msg.sender] != 0 && unstakingTimes[msg.sender] <= block.timestamp, "Cooldown period not ended");
        uint256 amount = stakes[msg.sender];
        stakes[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
