// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract WallyWalletNFTWithMetadata is ERC721Enumerable, Ownable {
    using Strings for uint256;

    uint256 private _tokenIdCounter;

    struct TokenMetadata {
        string cid;
        string title;
        string subtitle;
    }

    mapping(uint256 => TokenMetadata) private _tokenMetadata;

    constructor() ERC721("WallyWalletNFTWM", "WNFTM") {}


    function mintNFT(address to, string memory cid, string memory title, string memory subtitle) public onlyOwner {
        _safeMint(to, _tokenIdCounter);
        _setTokenMetadata(_tokenIdCounter, cid, title, subtitle);
        _tokenIdCounter = _tokenIdCounter + 1;
    }

    function _setTokenMetadata(uint256 tokenId, string memory cid, string memory title, string memory subtitle) internal virtual {
        require(_exists(tokenId), "ERC721Metadata: Metadata set of nonexistent token");
        _tokenMetadata[tokenId] = TokenMetadata(cid, title, subtitle);
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return _tokenMetadata[tokenId].cid;
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

    function tokenCIDsOfOwner(address owner) public view returns (string[] memory) {
        uint256[] memory tokenIds = tokensOfOwner(owner);
        uint256 tokenCount = tokenIds.length;

        string[] memory tokenCIDs = new string[](tokenCount);
        for (uint256 i = 0; i < tokenCount; i++) {
            tokenCIDs[i] = tokenURI(tokenIds[i]);
        }
        return tokenCIDs;
    }

    function tokenMetadataOfOwner(address owner) public view returns (TokenMetadata[] memory) {
        uint256[] memory tokenIds = tokensOfOwner(owner);
        uint256 tokenCount = tokenIds.length;

        TokenMetadata[] memory tokenMetadataList = new TokenMetadata[](tokenCount);
        for (uint256 i = 0; i < tokenCount; i++) {
            tokenMetadataList[i] = _tokenMetadata[tokenIds[i]];
        }
        return tokenMetadataList;
    }
}
