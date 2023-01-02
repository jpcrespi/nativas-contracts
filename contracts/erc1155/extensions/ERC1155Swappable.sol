/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./ERC1155Offsettable.sol";
import "./ERC1155Mintable.sol";

/**
 * @dev Offset Implementation
 */
contract ERC1155Swappable is ERC1155Offsettable, ERC1155Mintable {
    constructor(address logger_) ERC1155Offsettable(logger_) {}

    function _swap(
        address account,
        uint256 fromId,
        uint256 toId,
        uint256 value,
        bytes memory data
    ) internal virtual {
        require(_offsettable[fromId] == false, "ERC1155WE01");
        require(_offsettable[toId] == true, "ERC1155WE02");
        _burn(account, fromId, value, data);
        _mint(account, toId, value, data);
    }

    function _swapBatch(
        address account,
        uint256[] memory fromIds,
        uint256[] memory toIds,
        uint256[] memory values,
        bytes memory data
    ) internal virtual {
        for (uint256 i = 0; i < fromIds.length; i++) {
            require(_offsettable[fromIds[i]] == false, "ERC1155WE03");
        }
        for (uint256 i = 0; i < toIds.length; i++) {
            require(_offsettable[toIds[i]] == true, "ERC1155WE04");
        }
        _burnBatch(account, fromIds, values, data);
        _mintBatch(account, toIds, values, data);
    }
}
