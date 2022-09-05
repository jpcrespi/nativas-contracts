/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "../../../interfaces/erc1155/IERC1155.sol";
import "../../../interfaces/erc1155/IERC1155TokenReceiver.sol";

/**
 *
 */
contract ERC1155Holder is Context, ERC165, IERC1155TokenReceiver {
    //
    address internal _entity;
    uint256 internal _id;
    string internal _name;

    /**
     *
     */
    function setup(
        address entity_,
        uint256 id_,
        string memory name_,
        address operator_
    ) public {
        require(
            address(_entity) == address(0),
            "ERC1155Holder: holder already configured"
        );
        _entity = entity_;
        _id = id_;
        _name = name_;
        IERC1155(_entity).setApprovalForAll(operator_, true);
    }

    /**
     *
     */
    function entity() public view virtual returns (address) {
        return _entity;
    }

    /**
     *
     */
    function id() public view virtual returns (uint256) {
        return _id;
    }

    /**
     * @dev See {IERC20-name}.
     */
    function name() public view virtual returns (string memory) {
        return _name;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override
        returns (bool)
    {
        return
            interfaceId == type(IERC1155TokenReceiver).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC1155TokenReceiver-onERC1155Received}.
     */
    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    /**
     * @dev See {IERC1155TokenReceiver-onERC1155BatchReceived}.
     */
    function onERC1155BatchReceived(
        address,
        address,
        uint256[] memory,
        uint256[] memory,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }
}
