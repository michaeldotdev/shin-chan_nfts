// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "hardhat/console.sol";

import {Base64} from "./libraries/Base64.sol";

contract ShinChanNFT is ERC721URIStorage {
    // Keep track of tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Base SVG - only changing words
    string baseSvg =
        "<svg xmlns='https://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    string[] colors = [
        "RoyalBlue",
        "Lavender",
        "LightSkyBlue",
        "DarkOliveGreen",
        "CornflowerBlue",
        "DarkSlateBlue",
        "DarkSalmon",
        "OliveDrab",
        "Violet",
        "YellowGreen"
    ];
    string[] adjectives = [
        "Tart",
        "Wretched",
        "Obtainable",
        "Dashing",
        "Macho",
        "Dyanmic",
        "Fragile",
        "Dear",
        "Aware",
        "Robust"
    ];
    string[] nouns = [
        "Wave",
        "Cherries",
        "Toothpaste",
        "Development",
        "Porter",
        "Crook",
        "Worm",
        "Building",
        "Wood",
        "Tree"
    ];

    constructor() ERC721("SCNFT", "SQUARE") {
        console.log("This is my Shin Chan NFT contract");
    }

    // randomly pick a word from each array.
    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        // Squash the # between 0 and the length of the array to avoid going out of bounds.
        rand = rand % colors.length;
        return colors[rand];
    }

    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        rand = rand % adjectives.length;
        return adjectives[rand];
    }

    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );
        rand = rand % nouns.length;
        return nouns[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    // Function for user to hit to get their NFT
    function makeShinChanNFT() public {
        uint256 newItemId = _tokenIds.current(); // getting current tokenId - starts at 0

        string memory color = pickRandomFirstWord(newItemId);
        string memory adjective = pickRandomSecondWord(newItemId);
        string memory noun = pickRandomThirdWord(newItemId);
        string memory combinedWord = string(
            abi.encodePacked(color, adjective, noun)
        );

        // concat all together and place into baseSVG

        string memory completeSvg = string(
            abi.encodePacked(baseSvg, color, adjective, noun, "</text></svg>")
        );

        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        combinedWord,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(completeSvg)),
                        '"}'
                    )
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory completeTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(completeSvg);
        console.log("--------------------\n");

        //Mint NFT to sender with msg.sender
        _safeMint(msg.sender, newItemId);

        //Set NFTs data
        _setTokenURI(newItemId, completeTokenUri);
        console.log(
            "A NFT w/ ID %s has been minted to %s",
            completeTokenUri,
            msg.sender
        );

        _tokenIds.increment(); // Increase counter for next NFT
    }
}
