// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WallyWalletNFT is ERC721Enumerable, Ownable {
    using Strings for uint256;

    uint256 private _tokenIdCounter;
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC721("WallyWalletNFT", "WWNFT") {}

    function mintNFT(address to, string memory cid) public onlyOwner {
        _safeMint(to, _tokenIdCounter);
        _setTokenURI(_tokenIdCounter, cid);
        _tokenIdCounter = _tokenIdCounter + 1;
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        return _tokenURI;
    }

    function tokensOfOwner(address owner) public view returns (uint256[] memory) {
        uint256 tokenCount = balanceOf(owner);

        uint256[] memory tokensList = new uint256[](tokenCount);
        for (uint256 i = 0; i < tokenCount; i++) {
            tokensList[i] = tokenOfOwnerByIndex(owner, i);
        }
        return tokensList;
    }

    function transferNFT(address from, address to, uint256 tokenId) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        safeTransferFrom(from, to, tokenId);
    }
}
