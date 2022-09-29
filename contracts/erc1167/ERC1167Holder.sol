/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-1167

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../erc1155Receiver/ERC1155Holder.sol";

/**
 *
 */
contract ERC1167Holder is Context, Ownable {
    using Clones for address;

    // ERC1155TokenReceiver template
    address internal _template;
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
        _template = address(new ERC1155Holder());
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
    function putHolder(
        address entity,
        uint256 id,
        string memory name,
        address operator
    ) public virtual onlyOwner returns (address) {
        return _putHolder(entity, id, name, operator);
    }

    /**
     *
     */
    function _putHolder(
        address entity,
        uint256 id,
        string memory name,
        address operator
    ) internal virtual returns (address) {
        address holder = _template.clone();
        ERC1155Holder(holder).init(entity, operator, id, name);
        _holders[id] = holder;
        emit HolderCreated(id, holder);
        return holder;
    }
}
