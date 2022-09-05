/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "../../../interfaces/erc1155/IERC1155ERC20.sol";
import "../../access/roles/EditRole.sol";
import "../../erc20/ERC20Adapter.sol";
import "./ERC1155Supply.sol";

/**
 *
 */
contract ERC1155ERC20 is EditRole, ERC1155Supply, IERC1155ERC20 {
    // Mapping token id to adapter address
    mapping(uint256 => address) internal _adapters;

    /**
     *
     */
    event AdapterSet(uint256 indexed id, address indexed adapter);

    /**
     * @dev Grants `EDITOR_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(EDITOR_ROLE, _msgSender());
    }

    /**
     *
     */
    function setAdapter(uint256 id, address adapter) public virtual override {
        require(
            hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: caller is not the token adapter"
        );
        _setAdapter(id, adapter);
    }

    /**
     *
     */
    function getAdapter(uint256 id) public view virtual returns (address) {
        return _adapters[id];
    }

    /**
     *
     */
    function safeAdapterTransferFrom(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        require(
            _msgSender() == _adapters[id],
            "ERC1155: caller is not the token adapter"
        );
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
        returns (bool)
    {
        return _adapters[tokenId] != address(0);
    }

    /**
     *
     */
    function _setAdapter(uint256 id, address adapter) internal virtual {
        _adapters[id] = adapter;
        emit AdapterSet(id, adapter);
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
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
     * acceptance magic value.
     */
    function _safeAdapterTransferFrom(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155: transfer to the zero address");

        _transferFrom(operator, from, to, id, amount, data);

        _doSafeTransferAcceptanceCheck(operator, from, to, id, amount, data);
    }
}
