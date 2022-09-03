/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/erc1155/IERC1155ERC20.sol";
import "../../access/roles/EditRole.sol";
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
    event Adapter(uint256 indexed id, address indexed adapter);

    /**
     * @dev Grants `EDITOR_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(EDITOR_ROLE, _msgSender());
    }

    /**
     *
     */
    function setAdapter(uint256 tokenId, address adapter) public virtual {
        require(
            hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: caller is not the token adapter"
        );
        _setAdapter(tokenId, adapter);
    }

    /**
     *
     */
    function adapters(uint256 id) public view virtual returns (address) {
        return _adapters[id];
    }

    /**
     *
     */
    function transferFromAdapter(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        require(
            _msgSender() == adapters(id),
            "ERC1155: caller is not the token adapter"
        );
        _transferFrom(operator, from, to, id, amount, data);
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
        return adapters(tokenId) != address(0);
    }

    /**
     *
     */
    function _setAdapter(uint256 tokenId, address adapter) internal virtual {
        _adapters[tokenId] = adapter;
        emit Adapter(tokenId, adapter);
    }

    /**
     * @dev See {ERC1155-_beforeTokenTransfer}.
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
            uint256 tokenId = ids[i];
            require(
                exists(tokenId),
                "ERC1155: token does not exist (missing ERC20Adapter)"
            );
        }
    }
}
