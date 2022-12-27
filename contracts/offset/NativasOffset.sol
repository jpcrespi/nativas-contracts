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
    struct OffsetModel {
        uint256 tokenId;
        uint256 value;
        uint256 date;
        string info;
    }

    event PerformOffset(
        address indexed account,
        uint256 indexed tokenId,
        uint256 value,
        string info
    );

    // Mapping from token ID to account balances
    mapping(uint256 => mapping(address => uint256)) internal _balances;
    // offset data
    mapping(address => OffsetModel[]) private _offsets;
    // offset count
    mapping(address => uint256) private _offsetCount;

    /**
     * @dev Set Offset contract controller.
     */
    constructor() Controllable(_msgSender())  { }

    /**
     * @dev See {Controllable-_transferControl}.
     */
    function transferControl(address newController) public virtual {
        require(controller() == _msgSender(), "OFFSETE02");
        _transferControl(newController);
    }

    /**
     * @dev See {IERC1155-balanceOf}.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function balanceOf(address account, uint256 tokenId)
        public
        view
        virtual
        returns (uint256)
    {
        require(account != address(0), "ERC1155E01");
        return _balances[tokenId][account];
    }

    /**
     * @dev See {IERC1155-balanceOfBatch}.
     *
     * Requirements:
     *
     * - `accounts` and `ids` must have the same length.
     */
    function balanceOfBatch(address[] memory accounts, uint256[] memory tokenIds)
        public
        view
        virtual
        returns (uint256[] memory)
    {
        require(accounts.length == tokenIds.length, "ERC1155E02");

        uint256[] memory batchBalances = new uint256[](accounts.length);

        for (uint256 i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balanceOf(accounts[i], tokenIds[i]);
        }

        return batchBalances;
    }

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
        OffsetModel memory data = _offsets[account][index];
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
        require(controller() == _msgSender(), "OFFSETE02");
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
        _balances[tokenId][account] += value;
        _offsetCount[account]++;
        _offsets[account].push(OffsetModel(tokenId, value, block.timestamp, info));
    }
}
