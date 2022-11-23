/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "../../interfaces/erc1155/IERC1155Control.sol";
import "../../interfaces/erc1167/IERC1167Control.sol";

/**
 * @dev Contract module which provides a basic access control mechanism.
 */
contract NativasControl is 
    AccessControlEnumerable,
    IERC1155Control,
    IERC1167Control
{
    bytes32 public constant ADAPTER_ROLE = keccak256("ADAPTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant EDITOR_ROLE = keccak256("EDITOR_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant OFFSETER_ROLE = keccak256("OFFSETER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /**
     * @dev Grants all roles to the account that deploys the contract.
     */
    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _grantRole(BURNER_ROLE, _msgSender());
        _grantRole(ADAPTER_ROLE, _msgSender());
        _grantRole(MINTER_ROLE, _msgSender());
        _grantRole(OFFSETER_ROLE, _msgSender());
        _grantRole(PAUSER_ROLE, _msgSender());
        _grantRole(EDITOR_ROLE, _msgSender());
    }

    function isAdmin(
        address account
    ) public view virtual override(IERC1155Control, IERC1167Control) returns(bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, account);
    }

    function isBurner(
        address account
    ) public view virtual override returns(bool) {
        return hasRole(BURNER_ROLE, account);
    }

    function isAdapter(
        address account
    ) public view virtual override returns(bool) {
        return hasRole(ADAPTER_ROLE, account);
    }

    function isMinter(
        address account
    ) public view virtual override returns(bool) {
        return hasRole(MINTER_ROLE, account);   
    }

    function isOffsetter(
        address account
    ) public view virtual override returns(bool) {
        return hasRole(OFFSETER_ROLE, account);
    }

    function isPauser(
        address account
    ) public view virtual override returns(bool) {
        return hasRole(PAUSER_ROLE, account);
    }

    function isEditor(
        address account
    ) public view virtual override(IERC1155Control, IERC1167Control) returns(bool) {
        return hasRole(EDITOR_ROLE, account);
    }
}
