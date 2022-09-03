// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/mocks/AccessControlEnumerableMock.sol

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

/**
 *
 */
contract AccessControlEnumerableMock is AccessControlEnumerable {
    /**
     *
     */
    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    /**
     *
     */
    function setRoleAdmin(bytes32 roleId, bytes32 adminRoleId) public {
        _setRoleAdmin(roleId, adminRoleId);
    }

    /**
     *
     */
    function senderProtected(bytes32 roleId) public onlyRole(roleId) {}
}
