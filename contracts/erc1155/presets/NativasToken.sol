/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../extensions/ERC1155Mintable.sol";
import "../extensions/ERC1155Burnable.sol";
import "../extensions/ERC1155Pausable.sol";
import "../extensions/ERC1155Offsettable.sol";
import "../extensions/ERC1155URIStorable.sol";
import "../extensions/ERC1155ERC20.sol";

/**
 * @dev ERC1155 preset
 */
contract NativasToken is
    ERC1155Mintable,
    ERC1155Burnable,
    ERC1155Pausable,
    ERC1155Offsettable,
    ERC1155URIStorable,
    ERC1155ERC20
{
    constructor(string memory uri_, address template_)
        ERC1155URIStorable(uri_)
        ERC1155ERC20(template_)
    {}

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155Accessible, ERC1155URIStorable)
        returns (bool success)
    {
        return super.supportsInterface(interfaceId);
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 tokenId)
        public
        view
        virtual
        override(ERC1155ERC20, ERC1155URIStorable)
        returns (bool)
    {
        return ERC1155URIStorable.exists(tokenId);
    }

    /**
     *
     */
    function setMetadata(
        uint256 id,
        string memory name,
        string memory symbol,
        uint8 decimals,
        string memory uri,
        bool offsettable
    ) public virtual {
        putAdapter(id, name, symbol, decimals);
        setOffsettable(id, offsettable);
        setURI(id, uri);
    }

    /**
     *
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override(ERC1155, ERC1155Pausable, ERC1155Supply) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
