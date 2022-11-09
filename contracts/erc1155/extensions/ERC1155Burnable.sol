/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../access/roles/BurnRole.sol";
import "./ERC1155Accessible.sol";

/**
 * @dev Burn implementation
 */
contract ERC1155Burnable is BurnRole, ERC1155Accessible {
    /**
     * @dev Grants `BURNER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(BURNER_ROLE, _msgSender());
    }

    /**
     * @dev See {ERC1155Accessible-_burn}.
     *
     * Requirements:
     *
     * - the caller must have the `BURNER_ROLE`.
     * - the caller must be the owner or approved.
     */
    function burn(
        address account,
        uint256 id,
        uint256 value,
        bytes memory data
    ) public virtual {
        require(hasRole(BURNER_ROLE, _msgSender()), "E0201");
        require(_isOwnerOrApproved(account), "E0202");

        _burn(account, id, value, data);
    }

    /**
     * @dev See {ERC1155Accessible-_burnBatch}.
     *
     * Requirements:
     *
     * - the caller must have the `BURNER_ROLE`.
     * - the caller must be the owner or approved.
     */
    function burnBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory values,
        bytes memory data
    ) public virtual {
        require(hasRole(BURNER_ROLE, _msgSender()), "E0203");
        require(_isOwnerOrApproved(account), "E0204");

        _burnBatch(account, ids, values, data);
    }
}
