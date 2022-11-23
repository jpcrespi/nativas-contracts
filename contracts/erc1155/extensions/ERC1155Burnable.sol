/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC1155.sol";

/**
 * @dev Burn implementation
 */
contract ERC1155Burnable is ERC1155 {

    /**
     * @dev See {ERC1155Accessible-_burn}.
     *
     * Requirements:
     *
     * - the caller must have the `BURNER_ROLE`.
     * - the caller must be the owner or approved.
     */
    function _safeBurn(
        address account,
        uint256 id,
        uint256 value,
        bytes memory data
    ) internal virtual {
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
    function _safeBurnBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory values,
        bytes memory data
    ) internal virtual {
        require(_isOwnerOrApproved(account), "E0204");
        _burnBatch(account, ids, values, data);
    }

    /**
     * @dev Destroys `amount` tokens of token type `id` from `from`
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `from` must have at least `amount` tokens of token type `id`.
     */
    function _burn(
        address from,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(from != address(0), "E0101");

        address operator = _msgSender();
        uint256[] memory ids = _asSingletonArray(id);
        uint256[] memory amounts = _asSingletonArray(amount);

        _beforeTokenTransfer(operator, from, address(0), ids, amounts, data);

        uint256 fromBalance = _balances[id][from];
        require(fromBalance >= amount, "E0102");
        unchecked {
            _balances[id][from] = fromBalance - amount;
        }

        emit TransferSingle(operator, from, address(0), id, amount);

        _afterTokenTransfer(operator, from, address(0), ids, amounts, data);
    }

    /**
     * @dev Destroys `amounts` tokens of token type `ids` from `from`
     *
     * emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - `ids` and `amounts` must have the same length.
     * - `from` must have at least `amounts` tokens of token type `ids`.
     */
    function _burnBatch(
        address from,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {
        require(from != address(0), "E0103");
        require(ids.length == amounts.length, "E0104");

        address operator = _msgSender();

        _beforeTokenTransfer(operator, from, address(0), ids, amounts, data);

        for (uint256 i = 0; i < ids.length; i++) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];
            uint256 fromBalance = _balances[id][from];
            require(fromBalance >= amount, "E0105");
            unchecked {
                _balances[id][from] = fromBalance - amount;
            }
        }

        emit TransferBatch(operator, from, address(0), ids, amounts);

        _afterTokenTransfer(operator, from, address(0), ids, amounts, data);
    }
}
