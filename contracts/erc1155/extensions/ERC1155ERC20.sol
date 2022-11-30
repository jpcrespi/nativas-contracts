/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "../../../interfaces/erc1155/IERC1155ERC20.sol";
import "../../../interfaces/erc20/IERC20Adapter.sol";
import "./ERC1155Supply.sol";

/**
 *
 */
contract ERC1155ERC20 is ERC1155Supply, IERC1155ERC20 {
    using Clones for address;

    // NativasAdapter template
    address internal _template;
    // Mapping token id to adapter address
    mapping(uint256 => address) internal _adapters;

    /**
     * @dev MUST trigger when a new adapter is created.
     */
    event AdapterCreated(uint256 indexed id, address indexed adapter);

    /**
     * @dev Set NativasAdapter contract template
     */
    constructor(address template_) {
        _template = template_;
    }

    /**
     * @dev Get NativasAdapter contract template
     */
    function template() public view virtual returns (address) {
        return _template;
    }

    /**
     * @dev Get adpter contract address for token id.
     */
    function getAdapter(uint256 id) public view virtual returns (address) {
        return _adapters[id];
    }

    /**
     * @dev Perform tranfer from adapter contract.
     *
     * Requirements:
     *
     * - the caller MUST be the token adapter.
     */
    function safeAdapterTransferFrom(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        require(_msgSender() == _adapters[id], "ERC1155AE01");
        _safeAdapterTransferFrom(operator, from, to, id, amount, data);
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 tokenId)
        public
        view
        virtual
        override
        returns (bool) {
        return _adapters[tokenId] != address(0);
    }

    /**
     * @dev Create new adapter contract por token id
     */
    function _setAdapter(
        uint256 id,
        string memory name,
        string memory symbol,
        uint8 decimals
    ) internal virtual {
        address adapter = _template.clone();
        IERC20Adapter(adapter).init(id, name, symbol, decimals);
        _adapters[id] = adapter;
        emit AdapterCreated(id, adapter);
    }

    /**
     * @dev Transfers `amount` tokens of token type `id` from `from` to `to`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `from` must have a balance of tokens of type `id` of at least `amount`.
     * - If `to` refers to a smart contract, it must implement
     * {IERC1155Receiver-onERC1155Received} and return the acceptance magic value.
     */
    function _safeAdapterTransferFrom(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155AE02");
        _transferFrom(operator, from, to, id, amount, data);
        _doSafeTransferAcceptanceCheck(operator, from, to, id, amount, data);
    }

    /**
     * @dev See {ERC1155-_beforeTokenTransfer}.
     *
     * Requirements:
     *
     * - the contract must not be paused.
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
        for (uint256 i = 0; i < ids.length; ++i) {
            require(exists(ids[i]) == true, "ERC1155AE03");           
        }
    }
}
