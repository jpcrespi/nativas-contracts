/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC1155.sol";

/**
 * @dev Mint implementation
 */
contract ERC1155Mintable is ERC1155 {
    /**
     * @dev Creates `amount` tokens of token type `id`, and assigns them to `to`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - If `to` refers to a smart contract, it must implement
     * {IERC1155Receiver-onERC1155Received} and return the acceptance magic value.
     */
    function _mint(
        address to,
        uint256 tokenId,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERR-ERC1155M-01");

        address operator = _msgSender();
        uint256[] memory tokenIds = _asSingletonArray(tokenId);
        uint256[] memory amounts = _asSingletonArray(amount);

        _beforeTokenTransfer(operator, address(0), to, tokenIds, amounts, data);

        _balances[tokenId][to] += amount;
        emit TransferSingle(operator, address(0), to, tokenId, amount);

        _afterTokenTransfer(operator, address(0), to, tokenIds, amounts, data);

        _doSafeTransferAcceptanceCheck(
            operator,
            address(0),
            to,
            tokenId,
            amount,
            data
        );
    }

    /**
     * @dev Creates `amounts` tokens of token type `ids`, and assigns them to `to`.
     *
     * emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - `ids` and `amounts` must have the same length.
     * - If `to` refers to a smart contract, it must implement
     * {IERC1155Receiver-onERC1155BatchReceived} and return the acceptance magic value.
     */
    function _mintBatch(
        address to,
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERR-ERC1155M-02");
        require(tokenIds.length == amounts.length, "ERR-ERC1155M-03");

        address operator = _msgSender();

        _beforeTokenTransfer(operator, address(0), to, tokenIds, amounts, data);

        for (uint256 i = 0; i < tokenIds.length; i++) {
            _balances[tokenIds[i]][to] += amounts[i];
        }

        emit TransferBatch(operator, address(0), to, tokenIds, amounts);

        _afterTokenTransfer(operator, address(0), to, tokenIds, amounts, data);

        _doSafeBatchTransferAcceptanceCheck(
            operator,
            address(0),
            to,
            tokenIds,
            amounts,
            data
        );
    }
}
