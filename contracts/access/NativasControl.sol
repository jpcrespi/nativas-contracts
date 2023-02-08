/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "./NativasRoles.sol";

/**
 * @dev Contract module which provides a basic access control mechanism.
 */
contract NativasControl is AccessControlEnumerable {
    /**
     * @dev Grants all roles to the account that deploys the contract.
     */
    constructor() {
        _grantRole(Roles.ADMIN_ROLE, _msgSender());
        _grantRole(Roles.MINTER_ROLE, _msgSender());
        _grantRole(Roles.PAUSER_ROLE, _msgSender());
        _grantRole(Roles.EDITOR_ROLE, _msgSender());
        _grantRole(Roles.SWAPPER_ROLE, _msgSender());
        _grantRole(Roles.MANAGER_ROLE, _msgSender());
    }
}
