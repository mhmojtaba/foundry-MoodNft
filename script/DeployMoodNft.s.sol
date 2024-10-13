// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    MoodNft moodNft;
 
    // function setUp() public {}
    
    function run() public returns (MoodNft) {
        string memory happySvg = vm.readFile("images/happy.svg");
        string memory sadSvg = vm.readFile("images/sad.svg");
        vm.startBroadcast();

        // moodNft = new MoodNft(SAD_SVG_URI , HAPPY_SVG_URI);
        moodNft = new MoodNft(svgToUri(sadSvg) , svgToUri(happySvg));

        vm.stopBroadcast();

        return moodNft;
    }

    function svgToUri(string memory svg) pure public returns (string memory) {
        string memory baseUrl = "data:image/svg+xml;base64,";
        string memory imageURI = string(
            abi.encodePacked(
                baseUrl,
                Base64.encode(bytes(string(abi.encodePacked(svg))))
            )
        );
        return imageURI;
    }
}
