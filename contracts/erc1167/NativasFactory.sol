/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-1167

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../erc1155Receiver/NativasHolder.sol";

/**
 * ERC1167 implementation to create new holders
 */
contract NativasFactory is Context, Ownable {
    using Clones for address;

    // NativasHolder template
    address internal _template;
    // Mapping user id to holder address
    mapping(uint256 => address) internal _holders;

    /**
     * @dev MUST trigger when a new holder is created.
     */
    event HolderCreated(uint256 indexed id, address indexed holder);

    /**
     * @dev Set NativasHolder contract template.
     */
    constructor(address template_) {
        _template = template_;
    }

    /**
     * @dev get holder contract template
     */
    function template() public view virtual returns (address) {
        return _template;
    }

    /**
     * @dev get holder contract by id.
     */
    function getHolder(uint256 id) public view virtual returns (address) {
        return _holders[id];
    }

    /**
     * @dev See {NativasFactory-_putHolder}
     *
     * Requirements:
     *
     * - the caller must be the contract owener.
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
     * @dev Create a new holder contract.
     */
    function _putHolder(
        address entity,
        uint256 id,
        string memory name,
        address operator
    ) internal virtual returns (address) {
        address holder = _template.clone();
        NativasHolder(holder).init(entity, operator, id, name);
        _holders[id] = holder;
        emit HolderCreated(id, holder);
        return holder;
    }
}
