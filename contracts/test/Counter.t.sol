// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {BuyAndSell} from "../src/BuyAndSell.sol";
import {Staking} from "../src/Staking.sol";

contract DeploymentTest is Test {
    BuyAndSell buyAndSell;
    Staking staking;
    

    function setUp() public {
        // Deploy BuyAndSell contract
        buyAndSell = new BuyAndSell();

        // Deploy Staking contract
        staking = new Staking();

    }

    function testBuyAndSellBuy() public {
        // Simulate sending 1 ether to buy 1 token
        vm.deal(address(this), 1 ether);
        buyAndSell.buy{value: 1 ether}(1 ether);

        // Check if the balance of the caller increased
        assertEq(buyAndSell.balances(address(this)), 1 ether);
    }

    function testBuyAndSellSell() public {
        // Pre-buy tokens to allow selling
        vm.deal(address(this), 1 ether);
        buyAndSell.buy{value: 1 ether}(1 ether);

        // Simulate selling 0.5 ether worth of tokens
        buyAndSell.sell(0.5 ether);

        // Check if the balance was deducted
        assertEq(buyAndSell.balances(address(this)), 0.5 ether);
    }

    function testStakeAndUnstake() public {
        // Simulate staking 1 ether
        vm.deal(address(this), 1 ether);
        staking.stake{value: 1 ether}(1 ether);

        // Check if the stake balance increased
        assertEq(staking.stakes(address(this)), 1 ether);

        // Unstake the full amount
        staking.unstake(1 ether);

        // Check that unstaking triggered the cooldown
        assertEq(staking.unstakingTimes(address(this)), block.timestamp + 30 days);
    }

    function testWithdrawAfterCooldown() public {
        // Stake and unstake to trigger cooldown
        vm.deal(address(this), 1 ether);
        staking.stake{value: 1 ether}(1 ether);
        staking.unstake(1 ether);

        // Fast forward 30 days to allow withdrawal
        vm.warp(block.timestamp + 30 days);

        // Withdraw the unstaked amount
        staking.withdraw();

        // Check if the stake balance is reset
        assertEq(staking.stakes(address(this)), 0);
    }

}
