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
        _setTokenURI(
            newItemId,
            "data:application/json;base64,ewogICAgIm5hbWUiOiAiU3VwZXJGcmllZENoaWNrZW4iLAogICAgImRlc2NyaXB0aW9uIjogIkdyYWRpZW50IFN1cGVyRnJpZWRDaGlja2VuIE5GVCIsCiAgICAiaW1hZ2UiOiAiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhCeVpYTmxjblpsUVhOd1pXTjBVbUYwYVc4OUluaE5hVzVaVFdsdUlHMWxaWFFpSUhacFpYZENiM2c5SWpBZ01DQXpOVEFnTXpVd0lqNEtJQ0E4YzNSNWJHVStDaUFnSUNBdVltRnpaU0I3SUdacGJHdzZJSGRvYVhSbE95Qm1iMjUwTFdaaGJXbHNlVG9nYzJWeWFXWTdJR1p2Ym5RdGMybDZaVG9nTVRSd2VEc2dmUW9nSUR3dmMzUjViR1UrQ2lBZ1BHUmxabk0rQ2lBZ0lDQThiR2x1WldGeVIzSmhaR2xsYm5RZ2FXUTlJbXhwYm1WaGNpSWdlREU5SWpBbElpQjVNVDBpSlNJZ2VESTlJakV3TUNVaUlIa3lQU0l3SlNJK0NpQWdJQ0FnSUR4emRHOXdJRzltWm5ObGREMGlOU1VpSUhOMGIzQXRZMjlzYjNJOUlpTXdOVEU1TXpjaUx6NEtJQ0FnSUNBZ1BITjBiM0FnYjJabWMyVjBQU0l4TURBbElpQnpkRzl3TFdOdmJHOXlQU0lqTVRKRlFrVkNJaTgrQ2lBZ0lDQThMMnhwYm1WaGNrZHlZV1JwWlc1MFBnb2dJRHd2WkdWbWN6NEtJQ0E4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNKMWNtd29JMnhwYm1WaGNpa2lMejRLSUNBOGRHVjRkQ0I0UFNJMU1DVWlJSGs5SWpVd0pTSWdZMnhoYzNNOUltSmhjMlVpSUdSdmJXbHVZVzUwTFdKaGMyVnNhVzVsUFNKdGFXUmtiR1VpSUhSbGVIUXRZVzVqYUc5eVBTSnRhV1JrYkdVaVBsTjFjR1Z5Um5KcFpXUkRhR2xqYTJWdVBDOTBaWGgwUGdvOEwzTjJaejQ9Igp9"
        );
        console.log(
            "A NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        _tokenIds.increment(); // Increase counter for next NFT
    }
}
