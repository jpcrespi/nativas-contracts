/// SPDX-License-Identifier: MIT
/// @company: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

/**
 * @dev AccessControlEnumerable non-abstract implementation.
 */
contract AccessControlEnumerableStub is AccessControlEnumerable {

}

/**
 * @dev AccessControlEnumerableStub test mock implementation.
 */
contract AccessControlEnumerableMock is AccessControlEnumerableStub {
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
