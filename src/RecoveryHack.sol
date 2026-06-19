// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PredictAddress {
    function getAddress() external pure returns (address) {
        address factory = 0xa0cbdF678cCc1060445fDe0D4A2F4b22dCF1Ec6E;

        // The exact RLP encoding that Ethereum calculates under the hood
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), factory, bytes1(0x01)));
        return address(uint160(uint256(hash)));
    }
}

/*

This will send the funds from the lost contract to ${OWN_ADDRESS}. Any contract's funds can be recovered if the contract
has a function calling Solidity's selfdestruct. The lost address was found via Etherscan. It can be programmatically
predicted using the PredictAddress contract above.

> cast send --rpc-url ${SEPOLIA_RPC_URL} --account updraft ${RECOVERY_LOST_ADDRESS} "destroy(address payable)" ${OWN_ADDRESS}

*/