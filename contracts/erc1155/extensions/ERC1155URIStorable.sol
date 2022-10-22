/// SPDX-License-Identifier: MIT
/// @company: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "../../../interfaces/erc1155/IERC1155MetadataURI.sol";
import "../../access/roles/EditRole.sol";
import "./ERC1155Accessible.sol";

/**
 * @dev ERC1155 token with storage based token URI management.
 */
contract ERC1155URIStorable is
    EditRole,
    ERC1155Accessible,
    IERC1155MetadataURI
{
    using Strings for uint256;
    // Used as the URI for all token types by relying on ID substitution.
    string internal _uri;
    // Mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    /**
     * @dev Grants `EDITOR_ROLE` to the account that deploys the contract.
     */
    constructor(string memory uri_) {
        _setBaseURI(uri_);
        _grantRole(EDITOR_ROLE, _msgSender());
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
     * @dev See {ERC1155URIStorable-_setBaseURI}
     *
     * Requeriments:
     *
     * - the caller must have the `EDITOR_ROLE`.
     */
    function setBaseURI(string memory baseURI) public virtual {
        require(
            hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _setBaseURI(baseURI);
    }

    /**
     * @dev See {ERC1155URIStorable-_setURI}
     *
     * Requeriments:
     *
     * - the caller must have the `EDITOR_ROLE`.
     */
    function setURI(uint256 tokenId, string memory tokenURI) public virtual {
        require(
            hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _setURI(tokenId, tokenURI);
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
