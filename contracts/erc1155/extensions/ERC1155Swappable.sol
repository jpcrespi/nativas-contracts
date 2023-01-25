/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./ERC1155Offsettable.sol";

/**
 * @dev Offset Implementation
 */
contract ERC1155Swappable is ERC1155Offsettable {
    /**
     * @dev See {ERC1155Offsettable-constructor}
     */
    constructor(address logger_) ERC1155Offsettable(logger_) {}

    function _swap(
        address account,
        uint256 fromTokenId,
        uint256 toTokenId,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(
            _offsettable[fromTokenId] == false,
            "ERC1155Swappable: token from must not be offsettable"
        );
        require(
            _offsettable[toTokenId] == true,
            "ERC1155Swappable: token to must be offsettable"
        );
        _burn(account, fromTokenId, amount);
        _mint(account, toTokenId, amount, data);
    }

    function _swapBatch(
        address account,
        uint256[] memory fromTokenIds,
        uint256[] memory toTokenIds,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {
        for (uint256 i = 0; i < fromTokenIds.length; i++) {
            require(
                _offsettable[fromTokenIds[i]] == false,
                "ERC1155Swappable: token from must not be offsettable"
            );
        }
        for (uint256 i = 0; i < toTokenIds.length; i++) {
            require(
                _offsettable[toTokenIds[i]] == true,
                "ERC1155Swappable: token to must be offsettable"
            );
        }
        _burnBatch(account, fromTokenIds, amounts);
        _mintBatch(account, toTokenIds, amounts, data);
    }
}
