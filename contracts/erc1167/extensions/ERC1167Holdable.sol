/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-1167

pragma solidity ^0.8.0;

import "../../erc1155Receiver/extensions/ERC1155HolderFactory.sol";
import "./ERC1167Ownable.sol";

/**
 *
 */
contract ERC1167Holdable is ERC1167Ownable {
    // ERC1155TokenReceiver template
    address internal _holderTemplate;
    // Mapping user id to holder address
    mapping(uint256 => address) internal _holders;

    /**
     *
     */
    event HolderCreated(uint256 indexed id, address indexed holder);

    /**
     *
     */
    constructor() {
        _holderTemplate = address(new ERC1155HolderFactory());
    }

    /**
     *
     */
    function getHolder(uint256 id) public view virtual returns (address) {
        return _holders[id];
    }

    /**
     *
     */
    function createHolder(
        address entity,
        uint256 id,
        string memory name,
        address operator
    ) public virtual onlyOwner returns (address) {
        return _createHolder(entity, id, name, operator);
    }

    /**
     *
     */
    function _createHolder(
        address entity,
        uint256 id,
        string memory name,
        address operator
    ) internal virtual returns (address) {
        address holder = deploy(_holderTemplate);
        ERC1155HolderFactory(holder).init(entity, operator, id, name);
        _holders[id] = holder;
        emit HolderCreated(id, holder);
        return holder;
    }
}
