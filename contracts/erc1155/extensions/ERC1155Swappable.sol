/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./ERC1155Offsettable.sol";
import "./ERC1155Mintable.sol";

/**
 * @dev Offset Implementation
 */
contract ERC1155Swappable is ERC1155Offsettable, ERC1155Mintable {
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
        require(_offsettable[fromTokenId] == false, "ERR-ERC1155W-01");
        require(_offsettable[toTokenId] == true, "ERR-ERC1155W-02");
        _safeBurn(account, fromTokenId, amount, data);
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
            require(_offsettable[fromTokenIds[i]] == false, "ERR-ERC1155W-03");
        }
        for (uint256 i = 0; i < toTokenIds.length; i++) {
            require(_offsettable[toTokenIds[i]] == true, "ERR-ERC1155W-04");
        }
        _safeBurnBatch(account, fromTokenIds, amounts, data);
        _mintBatch(account, toTokenIds, amounts, data);
    }
}
