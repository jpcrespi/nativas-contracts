/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "../../../interfaces/erc1155/IERC1155Logger.sol";
import "./ERC1155Base.sol";

/**
 * @dev Offset Implementation
 */
contract ERC1155Offsettable is ERC1155Base {
    // Offset logger
    IERC1155Logger internal _logger;
    // Mapping token id to offsettable value
    mapping(uint256 => bool) internal _offsettable;

    /**
     * @dev Set IERC1155Logger implementation
     */
    constructor(address logger_) {
        _setLogger(logger_);
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
        string memory reason
    ) public virtual {
        require(_isOwnerOrApproved(account), "ERR-ERC1155O-01");
        _burn(account, tokenId, amount);
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
        string[] memory reasons
    ) public virtual {
        require(_isOwnerOrApproved(account), "ERR-ERC1155O-02");
        _burnBatch(account, tokenIds, amounts);
        _offsetBatch(account, tokenIds, amounts, reasons);
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
    function _offsetBatch(
        address account,
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        string[] memory reasons
    ) internal virtual {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            _offset(account, tokenIds[i], amounts[i], reasons[i]);
        }
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
        require(_offsettable[tokenId], "ERR-ERC1155O-03");
        _logger.offset(account, tokenId, amount, reason);
    }

    /**
     * @dev Sets the logger contract
     *
     * Requirements:
     *
     * - the template address must not be address 0.
     * - tem template contract must implemente the IERC1155Logger interface
     */
    function _setLogger(address logger_) internal virtual {
        require(logger_ != address(0), "ERR-ERC1155O-04");
        require(
            IERC165(logger_).supportsInterface(
                type(IERC1155Logger).interfaceId
            ),
            "ERR-ERC1155O-05"
        );
        _logger = IERC1155Logger(logger_);
    }
}
