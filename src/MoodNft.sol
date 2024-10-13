// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    // errors
    error MoodNft__NotOwner();

    uint256 private s_tokenCounter; // tokenId
    string private s_sadSvg;
    string private s_happySvg;

    enum Mood {HAPPY, SAD }

    mapping (uint256=>Mood) private s_tokenIdToMood;
    constructor(string memory _sadSvg, string memory _happySvg) ERC721("Mood NFT", "MDN") {
        s_tokenCounter = 0;
        s_happySvg = _happySvg;
        s_sadSvg = _sadSvg;
    }

    function mintNft()public {
        _safeMint(msg.sender , s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
        
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view  returns (bool) {
    return ERC721._getApproved(tokenId) == spender || ERC721._requireOwned(tokenId) == spender || spender == address(uint160(tokenId));
}

    function toggleMood(uint256 tokenId) public view{
        if(!_isApprovedOrOwner(msg.sender, tokenId)){
            revert MoodNft__NotOwner();
        }
        s_tokenIdToMood[tokenId] == Mood.HAPPY ? s_tokenIdToMood[tokenId] == Mood.SAD : s_tokenIdToMood[tokenId] == Mood.HAPPY;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageUri;

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageUri = s_happySvg;
        } else {
            imageUri = s_sadSvg;
        }

        bytes memory tokenMetadata = abi.encodePacked(
            '{"name": "', name() ,'", "description": "check and show the owners mood" , "attributes": [{"type" : "mood" , "value" : "100"}] , "image" : "', imageUri ,'" }'
        ); // converting metadata to bytes with the neccesary data

        string memory tokenuri = string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(tokenMetadata)
            )
        );// converting bytes metadata to valid string with the help of Base64 library

        return tokenuri;
    }
}
