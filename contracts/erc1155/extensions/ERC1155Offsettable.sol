/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "../../../interfaces/erc1155/IERC1155Logger.sol";
import "./ERC1155Burnable.sol";

/**
 * @dev Offset Implementation
 */
contract ERC1155Offsettable is ERC1155Burnable {
    IERC1155Logger internal _logger;

    mapping(uint256 => bool) internal _offsettable;

    constructor(address logger_) {
        _logger = IERC1155Logger(logger_);
    }

    function logger() public view virtual returns (address) {
        return address(_logger);
    }

    function offsettable(uint256 tokenId) public view virtual returns (bool) {
        return _offsettable[tokenId];
    }

    function offset(
        address account,
        uint256 tokenId,
        uint256 amount,
        string memory reason,
        bytes memory data
    ) public virtual {
        require(_isOwnerOrApproved(account), "ERC1155OE01");
        _burn(account, tokenId, amount, data);
        _offset(account, tokenId, amount, reason);
    }

    function offsetBatch(
        address account,
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        string[] memory reasons,
        bytes memory data
    ) public virtual {
        require(_isOwnerOrApproved(account), "ERC1155OE03");
        _burnBatch(account, tokenIds, amounts, data);
        for (uint256 i = 0; i < tokenIds.length; i++) {
            _offset(account, tokenIds[i], amounts[i], reasons[i]);
        }
    }

    function _setOffsettable(uint256 tokenId, bool enabled) internal virtual {
        _offsettable[tokenId] = enabled;
    }

    function _offset(
        address account,
        uint256 tokenId,
        uint256 amount,
        string memory reason
    ) internal virtual {
        require(_offsettable[tokenId], "ERC1155OE02");
        _logger.offset(account, tokenId, amount, reason);
    }
}
