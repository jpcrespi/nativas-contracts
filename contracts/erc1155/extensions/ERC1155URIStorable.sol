/// SPDX-License-Identifier: MIT
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

    // Mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    /**
     * @dev Grants `EDITOR_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(EDITOR_ROLE, _msgSender());
    }

    /**
     *
     */
    function setURI(uint256 tokenId, string memory tokenURI) public virtual {
        require(
            hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _setURI(tokenId, tokenURI);
    }

    /**
     * @dev See {IERC1155MetadataURI-uri}.
     *
     * This implementation returns the concatenation of the `_baseURI`
     * and the token-specific uri if the latter is set
     *
     * This enables the following behaviors:
     *
     * - if `_tokenURIs[tokenId]` is set, then the result is the concatenation
     *   of `_baseURI` and `_tokenURIs[tokenId]` (keep in mind that `_baseURI`
     *   is empty per default);
     *
     * - if `_tokenURIs[tokenId]` is NOT set then we fallback to `super.uri()`
     *   which in most cases will contain `ERC1155._uri`;
     *
     * - if `_tokenURIs[tokenId]` is NOT set, and if the parents do not have a
     *   uri value set, then the result is empty.
     */
    function uri(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        return _tokenURIs[tokenId];
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 tokenId) public view virtual returns (bool) {
        return bytes(_tokenURIs[tokenId]).length > 0;
    }

    /**
     * @dev Sets `tokenURI` as the tokenURI of `tokenId`.
     */
    function _setURI(uint256 tokenId, string memory tokenURI) internal virtual {
        _tokenURIs[tokenId] = tokenURI;
        emit URI(tokenURI, tokenId);
    }
}
