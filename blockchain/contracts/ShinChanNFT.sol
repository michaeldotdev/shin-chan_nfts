// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract ShinChanNFT is ERC721URIStorage {
    // Keep track of tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("SCNFT", "SQUARE") {
        console.log("This is my Shin Chan NFT contract");
    }

    // Function for user to hit to get their NFT
    function makeShinChanNFT() public {
        uint256 newItemId = _tokenIds.current(); // getting current tokenId - starts at 0

        //Mint NFT to sender with msg.sender
        _safeMint(msg.sender, newItemId);

        //Set NFTs data
        _setTokenURI(newItemId, "https://jsonkeeper.com/b/JRUF");
        console.log(
            "A NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        _tokenIds.increment(); // Increase counter for next NFT
    }
}
