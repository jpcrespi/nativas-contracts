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
contract ERC1155Offsettable is ERC1155Burnable
{
    IERC1155Logger internal _logger;

    constructor(address logger_) {
        _logger = IERC1155Logger(logger_);
    }

    function logger() public view virtual returns(address) {
        return address(_logger);
    }

    function offset(
        address account,
        uint256 tokenId,
        uint256 value,
        string memory info,
        bytes memory data
    ) public virtual {
        require(_isOwnerOrApproved(account), "ERC1155OE01");
        _burn(account, tokenId, value, data);
        _logger.offset(account, tokenId, value, info);
    }

    function offsetBatch(
        address account,
        uint256[] memory tokenIds,
        uint256[] memory values,
        string[] memory infos,
        bytes memory data
    ) public virtual {
        require(_isOwnerOrApproved(account), "ERC1155OE02");
        _burnBatch(account, tokenIds, values, data);
        for (uint256 i = 0; i < tokenIds.length; i++) {
            _logger.offset(account, tokenIds[i], values[i], infos[i]);
        }
    }
}
