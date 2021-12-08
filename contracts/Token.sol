//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "base64-sol/base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Token is ERC721, Ownable {
    uint private _tokenIndex = 0;

    constructor() ERC721("Token", "TKN") {
    }

    function _getSVG(uint256 tokenId) private pure returns (string memory) {
        return string(
            abi.encodePacked(
                "<svg viewBox=\\\"0 0 350 350\\\" xmlns=\\\"http://www.w3.org/2000/svg\\\" style=\\\"background-color: black;\\\">",
                "<text x=\\\"5\\\" y=\\\"15\\\" fill=\\\"white\\\">Token #",
                Strings.toString(tokenId),
                "</text></svg>"
            )
        );
    }

    function tokenURI(uint256 tokenId) override public pure returns (string memory) {
        string memory svg = _getSVG(tokenId);
        string memory json = Base64.encode(bytes(string(
            abi.encodePacked(
                "{\"name\":\"Token #",
                Strings.toString(tokenId),
                "\",\"image\":\"",
                svg,
                "\"}"
            )
        )));

        return string(abi.encodePacked("data:application/json;base64,", json));
    }

    function mint() public {
        _safeMint(msg.sender, _tokenIndex);
        _tokenIndex++;
    }
}
