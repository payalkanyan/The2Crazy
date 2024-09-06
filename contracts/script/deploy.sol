// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./contracts/BuyAndSell.sol";
import "./contracts/Staking.sol";
import "./contracts/ZKVerifier.sol";

contract Deploy {
    function deploy() external returns (address buyAndSell, address staking, address zkVerifier) {
        BuyAndSell _buyAndSell = new BuyAndSell();
        Staking _staking = new Staking();
        ZKVerifier _zkVerifier = new ZKVerifier();

        return (_buyAndSell, _staking, _zkVerifier);
    }
}
