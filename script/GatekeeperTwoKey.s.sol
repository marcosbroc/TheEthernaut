// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/Test.sol";
import {Script} from "forge-std/Script.sol";

contract GatekeeperTwoKeyTest is Script {
    function run(address gateLock) public {
        calculateGatekeeperTwoKey(gateLock);
    }

    function calculateGatekeeperTwoKey(address gateLock) public view {
        // The lock will give us the "shape" that we need to adapt to
        uint64 lock = uint64(bytes8(keccak256(abi.encodePacked(gateLock))));

        // The gate key will be "shaped" with a 1 where there is a 0 in the lock
        uint64 gateKey = 0;

        // We traverse the lock bit by bit
        for (uint8 f = 0; f < 64; f++) {
            // If the bit is 0, it needs to be set to 1
            if ((lock >> f) & 1 == 0) {
                // We set the relevant bit to 1
                gateKey = gateKey + uint64(2 ** f);
            }
        }

        console.log(gateKey);
    }
}
