/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// Note: checked

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @dev AccessControl non-abstract implementation.
 */
contract AccessControlStub is AccessControl {

}

/**
 * @dev AccessControl test mock implementation.
 */
contract AccessControlMock is AccessControlStub {
    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    function setRoleAdmin(bytes32 roleId, bytes32 adminRoleId) public {
        _setRoleAdmin(roleId, adminRoleId);
    }

    function senderProtected(bytes32 roleId)
        public
        view
        onlyRole(roleId)
        returns (bool)
    {
        return true;
    }
}
