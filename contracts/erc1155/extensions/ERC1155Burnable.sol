/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
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
        uint256 tokenId,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(_isOwnerOrApproved(account), "ERC1155BE01");
        _burn(account, tokenId, amount, data);
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
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {
        require(_isOwnerOrApproved(account), "ERC1155BE02");
        _burnBatch(account, tokenIds, amounts, data);
    }

    /**
     * @dev Destroys `amount` tokens of token type `tokenId` from `from`
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `from` must have at least `amount` tokens of token type `tokenId`.
     */
    function _burn(
        address from,
        uint256 tokenId,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(from != address(0), "ERC1155BE03");

        address operator = _msgSender();
        uint256[] memory tokenIds = _asSingletonArray(tokenId);
        uint256[] memory amounts = _asSingletonArray(amount);

        _beforeTokenTransfer(
            operator,
            from,
            address(0),
            tokenIds,
            amounts,
            data
        );

        uint256 fromBalance = _balances[tokenId][from];
        require(fromBalance >= amount, "ERC1155BE04");
        unchecked {
            _balances[tokenId][from] = fromBalance - amount;
        }

        emit TransferSingle(operator, from, address(0), tokenId, amount);

        _afterTokenTransfer(
            operator,
            from,
            address(0),
            tokenIds,
            amounts,
            data
        );
    }

    /**
     * @dev Destroys `amounts` tokens of token type `tokenIds` from `from`
     *
     * emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - `ids` and `amounts` must have the same length.
     * - `from` must have at least `amounts` tokens of token type `tokenIds`.
     */
    function _burnBatch(
        address from,
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {
        require(from != address(0), "ERC1155BE05");
        require(tokenIds.length == amounts.length, "ERC1155BE06");

        address operator = _msgSender();

        _beforeTokenTransfer(
            operator,
            from,
            address(0),
            tokenIds,
            amounts,
            data
        );

        for (uint256 i = 0; i < tokenIds.length; i++) {
            uint256 id = tokenIds[i];
            uint256 amount = amounts[i];
            uint256 fromBalance = _balances[id][from];
            require(fromBalance >= amount, "ERC1155BE07");
            unchecked {
                _balances[id][from] = fromBalance - amount;
            }
        }

        emit TransferBatch(operator, from, address(0), tokenIds, amounts);

        _afterTokenTransfer(
            operator,
            from,
            address(0),
            tokenIds,
            amounts,
            data
        );
    }
}
