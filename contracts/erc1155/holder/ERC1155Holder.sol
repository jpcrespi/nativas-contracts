/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "../../../interfaces/erc1155/IERC1155.sol";
import "../../../interfaces/erc1155/IERC1155TokenReceiver.sol";

/**
 *
 */
contract ERC1155Holder is
    Ownable,
    ERC165,
    Initializable,
    IERC1155TokenReceiver
{
    //
    uint256 internal _id;
    string internal _name;

    /**
     *
     */
    function init(
        address owner_,
        uint256 id_,
        string memory name_,
        address entity_,
        address operator_
    ) public initializer {
        _id = id_;
        _name = name_;
        transferOwnership(owner_);
        setApprovalForAll(entity_, operator_, true);
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

    /**
     *
     */
    function setApprovalForAll(
        address entity_,
        address operator_,
        bool approved
    ) public virtual onlyOwner {
        IERC1155(entity_).setApprovalForAll(operator_, approved);
    }
}
