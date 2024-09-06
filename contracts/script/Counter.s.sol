// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {BuyAndSell} from "../src/BuyAndSell.sol";
import {Staking} from "../src/Staking.sol";

contract DeploymentScript is Script {
    function run() external {
        // Start the deployment process
        vm.startBroadcast();

        // Deploy BuyAndSell contract
        BuyAndSell buyAndSell = new BuyAndSell();
        console2.log("BuyAndSell deployed at:", address(buyAndSell));

        // Deploy Staking contract
        Staking staking = new Staking();
        console2.log("Staking deployed at:", address(staking));

        
        vm.stopBroadcast();
    }
}
