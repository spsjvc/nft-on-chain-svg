//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Token is ERC721, Ownable {
    uint private _tokenIndex = 0;

    constructor() ERC721("Token", "TKN") {
    }

    function mint() public {
        _safeMint(msg.sender, _tokenIndex);
        _tokenIndex++;
    }
}
