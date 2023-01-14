/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "../../interfaces/erc1155/IERC1155Control.sol";

/**
 * @dev Contract module which provides a basic access control mechanism.
 */
contract NativasControl is AccessControlEnumerable, IERC1155Control {
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant EDITOR_ROLE = keccak256("EDITOR_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant SWAPPER_ROLE = keccak256("SWAPPER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /**
     * @dev Grants all roles to the account that deploys the contract.
     */
    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _grantRole(BURNER_ROLE, _msgSender());
        _grantRole(MINTER_ROLE, _msgSender());
        _grantRole(PAUSER_ROLE, _msgSender());
        _grantRole(EDITOR_ROLE, _msgSender());
        _grantRole(SWAPPER_ROLE, _msgSender());
    }

    /**
     * @dev Returns `true` if `account` has been granted `DEFAULT_ADMIN_ROLE`.
     */
    function isAdmin(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(DEFAULT_ADMIN_ROLE, account);
    }

    /**
     * @dev Returns `true` if `account` has been granted `BURNER_ROLE`.
     */
    function isBurner(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(BURNER_ROLE, account);
    }

    /**
     * @dev Returns `true` if `account` has been granted `MINTER_ROLE`.
     */
    function isMinter(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(MINTER_ROLE, account);
    }

    /**
     * @dev Returns `true` if `account` has been granted `PAUSER_ROLE`.
     */
    function isPauser(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(PAUSER_ROLE, account);
    }

    /**
     * @dev Returns `true` if `account` has been granted `EDITOR_ROLE`.
     */
    function isEditor(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(EDITOR_ROLE, account);
    }

    /**
     * @dev Returns `true` if `account` has been granted `SWAPPER_ROLE`.
     */
    function isSwapper(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(SWAPPER_ROLE, account);
    }
}
