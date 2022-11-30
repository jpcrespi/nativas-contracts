/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-1167

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../../interfaces/erc1155/IERC1155Holder.sol";
import "../access/Controllable.sol";

/**
 * ERC1167 implementation to create new holders
 */
contract NativasFactory is Context, Controllable {
    using Clones for address;

    // NativasHolder template
    address internal _template;
    // Mapping user id to holder address
    mapping(uint256 => address) internal _holders;

    /**
     * @dev MUST trigger when a new holder is created.
     */
    event HolderCreated(
        uint256 indexed id, 
        address indexed holder
    );

    /**
     * @dev Set NativasHolder contract template.
     */
    constructor(
        address controller_, 
        address template_) 
        Controllable(controller_) {
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
     * @dev See {Controllable-_safeTransferControl}.
     *
     * Requirements:
     *
     * - the caller must have the `DEFAULT_ADMIN_ROLE`.
     */
    function transferControl(address newController) public virtual {
        require(controller() == _msgSender(), "ERC1167E01");
        _transferControl(newController);
    }

    /**
     * @dev See {NativasFactory-_setHolder}
     *
     * Requirements:
     *
     * - the caller must be the contract owener.
     */
    function setHolder(
        address entity,
        uint256 id,
        string memory nin,
        string memory name,
        address controller_,
        address operator
    ) public virtual {
        require(controller() == _msgSender(), "ERC1167E02");
        _setHolder(entity, id, nin, name, operator, controller_);
    }

    /**
     * @dev Create a new holder contract.
     */
    function _setHolder(
        address entity,
        uint256 id,
        string memory nin,
        string memory name,
        address controller,
        address operator
    ) internal virtual {
        address holder = _template.clone();
        IERC1155Holder(holder).init(entity, operator, controller, id, nin, name);
        _holders[id] = holder;
        emit HolderCreated(id, holder);
    }
}
