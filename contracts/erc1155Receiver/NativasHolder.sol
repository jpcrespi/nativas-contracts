/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "../../interfaces/erc1155/IERC1155.sol";
import "../../interfaces/erc1155/IERC1155Holder.sol";
import "../../interfaces/erc1155/IERC1155TokenReceiver.sol";
import "../access/Controllable.sol";

/**
 * @title ERC1155TokenReceiver implmentation
 */
contract NativasHolder is
    Context,
    ERC165,
    Controllable,
    Initializable,
    IERC1155Holder,
    IERC1155TokenReceiver
{
    // Holder metadata
    uint256 internal _holderId;
    string internal _nin;
    string internal _name;

    /**
     * @dev Initialize template
     */
    constructor(
        address entity_,
        address operator_,
        address controller_,
        uint256 holderId_,
        string memory nin_,
        string memory name_
    ) Controllable(controller_) {
        init(entity_, operator_, controller_, holderId_, nin_, name_);
    }

    /**
     * @dev Initialize contract
     */
    function init(
        address entity_,
        address operator_,
        address controller_,
        uint256 holderId_,
        string memory nin_,
        string memory name_
    ) public virtual override initializer {
        _holderId = holderId_;
        _nin = nin_;
        _setName(name_);
        _transferControl(controller_);
        _setApprovalForAll(entity_, operator_, true);
    }

    /**
     * @return id of the holder account
     */
    function id() public view virtual returns (uint256) {
        return _holderId;
    }

    /**
     * @return nin national indentifier number
     */
    function nin() public view virtual returns (string memory) {
        return _nin;
    }

    /**
     * @return name of the holder account
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
            interfaceId == type(IERC1155Holder).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {Controllable-_transferControl}.
     */
    function transferControl(address controller_) public virtual {
        require(controller() == _msgSender(), "ERC1155RE01");
        _transferControl(controller_);
    }

    /**
     * @dev See {NativasHolder-_setApprovalForAll}.
     *
     * Requirements:
     *
     * - the caller must be the controller.
     */
    function setApprovalForAll(
        address entity_,
        address operator_,
        bool approved_
    ) public virtual {
        require(controller() == _msgSender(), "ERC1155RE02");
        _setApprovalForAll(entity_, operator_, approved_);
    }

    /**
     * @dev See {NativasHolder-_setName}.
     *
     * Requirements:
     *
     * - the caller must be the controller.
     */
    function setName(string memory name_) public virtual {
        require(controller() == _msgSender(), "ERC1155RE03");
        _setName(name_);
    }

    /**
     * @dev See {IERC1155-setApprovalForAll}.
     *
     * Requirements:
     *
     * - the entity must be an ERC1155 contract
     */
    function _setApprovalForAll(
        address entity_,
        address operator_,
        bool approved_
    ) internal virtual {
        if (entity_ == address(0)) {
            return;
        }
        IERC1155(entity_).setApprovalForAll(operator_, approved_);
    }

    /**
     * @dev Sets `name_` as the holder name.
     */
    function _setName(string memory name_) internal virtual {
        _name = name_;
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
