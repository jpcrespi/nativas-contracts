/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../extensions/ERC1155Mintable.sol";
import "../extensions/ERC1155Burnable.sol";
import "../extensions/ERC1155Pausable.sol";
import "../extensions/ERC1155Offsetable.sol";
import "../extensions/ERC1155URIStorable.sol";
import "../extensions/ERC1155ERC20.sol";

/**
 * @dev {ERC1155} token, including:
 *
 *  - ability for holders to burn (destroy) their tokens
 *  - a minter role that allows for token minting (creation)
 *  - a pauser role that allows to stop all token transfers
 *
 * This contract uses {AccessControl} to lock permissioned functions using the
 * different roles - head to its documentation for details.
 *
 * The account that deploys the contract will be granted the minter and pauser
 * roles, as well as the default admin role, which will let it grant both minter
 * and pauser roles to other accounts.
 *
 * _Deprecated in favor of https://wizard.openzeppelin.com/[Contracts Wizard]._
 */
contract ERC1155Preset is
    ERC1155Mintable,
    ERC1155Burnable,
    ERC1155Pausable,
    ERC1155Offsetable,
    ERC1155URIStorable,
    ERC1155ERC20
{
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
        address adapter,
        string memory uri
    ) public virtual {
        setAdapter(id, adapter);
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
