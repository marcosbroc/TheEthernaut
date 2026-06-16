// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrivacyHack {}

/**
 *
 * The storage slots of the Privacy contract are as follows:
 * - Slot 0: variable bool locked
 * - Slot 1: variable uint256 ID
 * - Slot 2:
 *     + variable uint8 flattening
 *     + variable uint8 denomination
 *     + variable uint16 awkwardness
 * - Slot 3: variable bytes32 data [0]
 * - Slot 4: variable bytes32 data [1]
 * - Slot 5: variable bytes32 data [2]
 *
 * Get the right slot
 * > cast storage ${PRIVACY_INSTANCE_ADDRESS} 5 --rpc-url ${SEPOLIA_RPC_URL}
 *
 * Cast from bytes32 to bytes16 as the function unlock() takes bytes16 as an argument
 * > echo "0x0f471c524be8e8f3aa0f94bacbb661354f32b71ce4cd7aae24e86e871beb2dec" | cut -c 1-34
 *
 * Execute the function unlock() with the right argument to unlock the contract
 * > cast send --rpc-url ${SEPOLIA_RPC_URL}
 *      --account updraft ${PRIVACY_INSTANCE_ADDRESS}
 *      "unlock(bytes16)" 0x0f471c524be8e8f3aa0f94bacbb66135
 *
 */