/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

/**
 * @title
 */
interface IERC1155Control {
    /**
     * @dev Returns `true` if `account` has been granted `admin` role.
     */
    function isAdmin(address account) external returns (bool);

    /**
     * @dev Returns `true` if `account` has been granted `burner` role.
     */
    function isBurner(address account) external returns (bool);

    /**
     * @dev Returns `true` if `account` has been granted `minter` role.
     */
    function isMinter(address account) external returns (bool);

    /**
     * @dev Returns `true` if `account` has been granted `pauser` role.
     */
    function isPauser(address account) external returns (bool);

    /**
     * @dev Returns `true` if `account` has been granted `editor` role.
     */
    function isEditor(address account) external returns (bool);

    /**
     * @dev Returns `true` if `account` has been granted `swapper` role.
     */
    function isSwapper(address account) external returns (bool);
}
