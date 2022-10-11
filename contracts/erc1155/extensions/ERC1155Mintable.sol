/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// Note: checked

pragma solidity ^0.8.0;

import "../../access/roles/MintRole.sol";
import "./ERC1155Accessible.sol";

/**
 * @dev Mint implementation
 */
contract ERC1155Mintable is MintRole, ERC1155Accessible {
    /**
     * @dev Grants `MINTER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(MINTER_ROLE, _msgSender());
    }

    /**
     * @dev See {ERC1155Accessible-_mint}.
     * Requirements:
     * - the caller must have the `MINTER_ROLE`.
     */
    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual {
        require(
            hasRole(MINTER_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _mint(to, id, amount, data);
    }

    /**
     * @dev See {ERC1155Accessible-_mintBatch}.
     * Requirements:
     * - the caller must have the `MINTER_ROLE`.
     */
    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual {
        require(
            hasRole(MINTER_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _mintBatch(to, ids, amounts, data);
    }
}
