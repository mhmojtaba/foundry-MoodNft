// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "src/MoodNft.sol";
import {DeployMoodNft} from "script/DeployMoodNft.s.sol";

contract MoodNftTest is Test {
    MoodNft public moodNft;
    DeployMoodNft public deployer;
    address user = makeAddr("user");

    function setUp() public {
        vm.startBroadcast();
        deployer = new DeployMoodNft();
        vm.stopBroadcast();
        moodNft = deployer.run();
    }
    function testMint ()public {
        vm.prank(user);
       moodNft.mintNft();
       console.log(moodNft.tokenURI(0));
    }
}
