/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "../../../interfaces/erc1155/IERC1155Logger.sol";
import "./ERC1155Burnable.sol";

/**
 * @dev Offset Implementation
 */
contract ERC1155Offsettable is ERC1155Burnable {
    // Offset logger
    IERC1155Logger internal _logger;
    // Mapping token id to offsettable value
    mapping(uint256 => bool) internal _offsettable;

    /**
     * @dev Set IERC1155Logger implementation
     */
    constructor(address logger_) {
        _logger = IERC1155Logger(logger_);
    }

    /**
     * @dev Get offset logger implementation address
     */
    function logger() public view virtual returns (address) {
        return address(_logger);
    }

    /**
     * @dev Get offsettable value by token id.
     */
    function offsettable(uint256 tokenId) public view virtual returns (bool) {
        return _offsettable[tokenId];
    }

    /**
     * @dev See {ERC1155Offsettable-_offset}.
     *
     * Requirements:
     *
     * - the caller must be owner or approved.
     */
    function offset(
        address account,
        uint256 tokenId,
        uint256 amount,
        string memory reason,
        bytes memory data
    ) public virtual {
        require(_offsettable[tokenId], "ERC1155OE02");
        _safeBurn(account, tokenId, amount, data);
        _offset(account, tokenId, amount, reason);
    }

    /**
     * @dev See {ERC1155Offsettable-_offset}.
     *
     * Requirements:
     *
     * - the caller must be owner or approved.
     */
    function offsetBatch(
        address account,
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        string[] memory reasons,
        bytes memory data
    ) public virtual {
        _safeBurnBatch(account, tokenIds, amounts, data);
        for (uint256 i = 0; i < tokenIds.length; i++) {
            require(_offsettable[tokenIds[i]], "ERC1155OE04");
            _offset(account, tokenIds[i], amounts[i], reasons[i]);
        }
    }

    /**
     * @dev Sets `enabled` as the offsettable value of `tokenId`.
     */
    function _setOffsettable(uint256 tokenId, bool enabled) internal virtual {
        _offsettable[tokenId] = enabled;
    }

    /**
     * @dev See {IERC1155Logger-offset}.
     */
    function _offset(
        address account,
        uint256 tokenId,
        uint256 amount,
        string memory reason
    ) internal virtual {
        _logger.offset(account, tokenId, amount, reason);
    }
}
