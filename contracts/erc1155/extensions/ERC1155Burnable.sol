/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../access/roles/BurnRole.sol";
import "./ERC1155Accessible.sol";

/**
 * @dev Implementation of the basic standard multi-token.
 * See https://eips.ethereum.org/EIPS/eip-1155
 * Originally based on code by Enjin: https://github.com/enjin/erc-1155
 *
 * _Available since v3.1._
 */
contract ERC1155Burnable is BurnRole, ERC1155Accessible {
    /**
     * @dev Grants `BURNER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(BURNER_ROLE, _msgSender());
    }

    /**
     *
     */
    function burn(
        address account,
        uint256 id,
        uint256 value,
        bytes memory data
    ) public virtual {
        require(
            hasRole(BURNER_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        require(
            _isOwnerOrApproved(account),
            "ERC1155: caller is not owner nor approved"
        );

        _burn(account, id, value, data);
    }

    /**
     *
     */
    function burnBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory values,
        bytes memory data
    ) public virtual {
        require(
            hasRole(BURNER_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        require(
            _isOwnerOrApproved(account),
            "ERC1155: caller is not owner nor approved"
        );

        _burnBatch(account, ids, values, data);
    }
}
