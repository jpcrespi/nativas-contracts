/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "../../../interfaces/erc1155/IERC1155MetadataURI.sol";
import "../ERC1155.sol";

/**
 * @dev ERC1155 token with storage based token URI management.
 */
contract ERC1155URIStorable is ERC1155, IERC1155MetadataURI
{
    using Strings for uint256;
    // Used as the URI for all token types by relying on ID substitution.
    string internal _uri;
    // Mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    /**
     * @dev
     */
    constructor(string memory uri_) {
        _setBaseURI(uri_);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override
        returns (bool success)
    {
        return
            interfaceId == type(IERC1155MetadataURI).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC1155MetadataURI-uri}.
     *
     * This implementation returns the concatenation of the `_uri`
     * and the token-specific uri if the latter is set
     */
    function uri(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        string memory tokenURI = _tokenURIs[tokenId];

        if (bytes(tokenURI).length > 0) {
            return string(abi.encodePacked(_uri, tokenURI));
        } else {
            return string(abi.encodePacked(_uri, tokenId.toString()));
        }
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 tokenId) public view virtual returns (bool) {
        return bytes(_tokenURIs[tokenId]).length > 0;
    }

    /**
     * @dev Sets `baseURI` as the `_uri` for all tokens
     */
    function _setBaseURI(string memory baseURI) internal virtual {
        _uri = baseURI;
    }

    /**
     * @dev Sets `tokenURI` as the tokenURI of `tokenId`.
     */
    function _setURI(uint256 tokenId, string memory tokenURI) internal virtual {
        _tokenURIs[tokenId] = tokenURI;
        emit URI(tokenURI, tokenId);
    }
}
