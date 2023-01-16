/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "../../interfaces/erc1155/IERC1155Logger.sol";
import "../access/Controllable.sol";

/**
 * @dev Offset Implementation
 */
contract NativasOffset is ERC165, Context, Controllable, IERC1155Logger {
    /**
     * @dev Offset model
     */
    struct OffsetModel {
        uint256 tokenId;
        uint256 amount;
        uint256 date;
        string reason;
    }

    event PerformOffset(
        address indexed account,
        uint256 indexed tokenId,
        uint256 amount,
        string reason
    );

    // Mapping from token identifier to account balances
    mapping(uint256 => mapping(address => uint256)) internal _balances;
    // offset data
    mapping(address => OffsetModel[]) private _offsets;
    // offset count
    mapping(address => uint256) private _offsetCount;

    /**
     * @dev Set Offset contract controller.
     */
    constructor() Controllable(_msgSender()) {}

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override
        returns (bool success)
    {
        return
            interfaceId == type(IERC1155Logger).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {Controllable-_transferControl}.
     */
    function transferControl(address controller_) public virtual {
        require(controller() == _msgSender(), "ERR-ERC1155L-01");
        require(controller_ != address(0), "ERR-ERC1155L-02");
        _transferControl(controller_);
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
        require(account != address(0), "ERR-ERC1155L-03");
        return _balances[tokenId][account];
    }

    /**
     * @dev See {IERC1155-balanceOfBatch}.
     *
     * Requirements:
     *
     * - `accounts` and `ids` must have the same length.
     */
    function balanceOfBatch(
        address[] memory accounts,
        uint256[] memory tokenIds
    ) public view virtual returns (uint256[] memory) {
        require(accounts.length == tokenIds.length, "ERR-ERC1155L-04");

        uint256[] memory batchBalances = new uint256[](accounts.length);

        for (uint256 i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balanceOf(accounts[i], tokenIds[i]);
        }

        return batchBalances;
    }

    /**
     * @dev Get the amount of offsets by account
     */
    function getOffsetCount(address account)
        public
        view
        virtual
        returns (uint256)
    {
        return _offsetCount[account];
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
            uint256 amount,
            uint256 date,
            string memory reason
        )
    {
        OffsetModel memory model = _offsets[account][index];
        return (model.tokenId, model.amount, model.date, model.reason);
    }

    /**
     * @dev See {IERC1155Logger-offset}
     *
     * Requirements:
     *
     * - the caller must be the controller.
     */
    function offset(
        address account,
        uint256 tokenId,
        uint256 amount,
        string memory reason
    ) public virtual override {
        require(controller() == _msgSender(), "ERR-ERC1155L-05");
        _offset(account, tokenId, amount, reason);
    }

    /**
     * @dev internal implementantion
     */
    function _offset(
        address account,
        uint256 tokenId,
        uint256 amount,
        string memory reason
    ) internal virtual {
        _balances[tokenId][account] += amount;
        _offsetCount[account]++;
        _offsets[account].push(
            OffsetModel(tokenId, amount, block.timestamp, reason)
        );
    }
}
