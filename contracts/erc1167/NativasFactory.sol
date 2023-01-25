/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-1167

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/IAccessControl.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "../../interfaces/erc1155/IERC1155Holder.sol";
import "../access/Controllable.sol";
import "../access/NativasRoles.sol";

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
        uint256 indexed holderId,
        address indexed holderAddress
    );

    /**
     * @dev Set NativasHolder contract template.
     */
    constructor(address controller_, address template_)
        Controllable(controller_)
    {
        _setTemplate(template_);
    }

    /**
     * @dev get holder contract template
     */
    function template() public view virtual returns (address) {
        return _template;
    }

    /**
     * @dev get holder contract by holderId.
     */
    function getHolder(uint256 holderId) public view virtual returns (address) {
        return _holders[holderId];
    }

    /**
     * @dev See {Controllable-_safeTransferControl}.
     *
     * Requirements:
     *
     * - the caller must be admin.
     * - new controller must implement IAccessControl interface
     */
    function transferControl(address controller_) public virtual {
        require(
            _hasRole(Roles.ADMIN_ROLE),
            "NativasFactory: caller must have admin role to tranfer control"
        );
        require(
            controller_ != address(0),
            "NativasFactory: new controller is the zero address"
        );
        require(
            IERC165(controller_).supportsInterface(
                type(IAccessControl).interfaceId
            ),
            "NativasFactory: new controller does not support IAccessControl interface"
        );
        _transferControl(controller_);
    }

    /**
     * @dev See {NativasFactory-_setHolder}
     *
     * Requirements:
     *
     * - the caller must be editor.
     */
    function setHolder(
        address entity_,
        uint256 holderId_,
        string memory nin_,
        string memory name_,
        address controller_,
        address operator_
    ) public virtual {
        require(
            _hasRole(Roles.MANAGER_ROLE),
            "NativasFactory: caller must have manager role to set holder"
        );
        _setHolder(entity_, holderId_, nin_, name_, operator_, controller_);
    }

    /**
     * @dev See {NativasFactory-_updateTemplate}
     *
     * Requirements:
     *
     * - the caller must be editor.
     */
    function setTemplate(address template_) public virtual {
        require(
            _hasRole(Roles.ADMIN_ROLE),
            "NativasFactory: caller must have admin role to set template"
        );
        _setTemplate(template_);
    }

    /**
     * @dev Create a new holder contract.
     */
    function _setHolder(
        address entity,
        uint256 holderId,
        string memory nin,
        string memory name,
        address controller,
        address operator
    ) internal virtual {
        require(
            _template != address(0),
            "NativasFactory: template is the zero address"
        );
        address holderAddress = _template.clone();
        IERC1155Holder(holderAddress).init(
            entity,
            operator,
            controller,
            holderId,
            nin,
            name
        );
        _holders[holderId] = holderAddress;
        emit HolderCreated(holderId, holderAddress);
    }

    /**
     * @dev See {IAccessControl-hasRole}
     */
    function _hasRole(bytes32 role) internal virtual returns (bool) {
        return IAccessControl(controller()).hasRole(role, _msgSender());
    }

    /**
     * @dev Sets the holder template contract
     *
     * Requirements:
     *
     * - the template address must not be address 0.
     * - tem template contract must implemente the IERC1155Holder interface
     */
    function _setTemplate(address template_) internal virtual {
        require(
            template_ != address(0),
            "NativasFactory: new template is the zero address"
        );
        require(
            IERC165(template_).supportsInterface(
                type(IERC1155Holder).interfaceId
            ),
            "NativasFactory: new template does not support IERC1155Holder interface"
        );
        _template = template_;
    }
}
