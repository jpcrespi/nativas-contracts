/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "../../interfaces/erc1155/IERC1155Logger.sol";
import "../access/Controllable.sol";

/**
 * @dev Offset Implementation
 */
contract NativasOffset is Context, Controllable, IERC1155Logger {

    /**
     * @dev Offset model
     */
    struct Offset {
        uint256 tokenId;
        uint256 value;
        uint256 date;
        string info;
    }

    // offset data
    mapping(address => Offset[]) private _offsets;
    mapping(address => uint256) private _offsetCount;

    /**
     * @dev Set Offset contract controller.
     */
    constructor() Controllable(_msgSender())  { }

    /**
     * @dev Get offset data from and account and an index.
     */
    function getOffsetValue(address account, uint256 index)
        public
        view
        virtual
        returns (
            uint256 tokenId,
            uint256 value,
            uint256 date,
            string memory info
        ) {
        Offset memory data = _offsets[account][index];
        return (data.tokenId, data.value, data.date, data.info);
    }

    /**
     * @dev Get the amount of offsets by account
     */
    function getOffsetCount(address account)
        public
        view
        virtual
        returns (uint256) {
        return _offsetCount[account];
    }

    /**
     * @dev See {OffsetBook-_offset}
     *
     * Requirements:
     *
     * - the caller must be the controller.
     */
    function offset(
        address account,
        uint256 tokenId,
        uint256 value,
        string memory info
    ) public virtual override {
        require(controller() == _msgSender(), "OFFSETE01");
        _offset(account, tokenId, value, info);
    }

    /**
     * @dev
     */
    function _offset(
        address account,
        uint256 tokenId,
        uint256 value,
        string memory info
    ) internal virtual {
        _offsetCount[account]++;
        _offsets[account].push(Offset(tokenId, value, block.timestamp, info));
    }
}
