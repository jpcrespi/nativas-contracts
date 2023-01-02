/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

/**
 * @title
 */
interface IERC1155Control {
    function isAdmin(address account) external returns (bool);

    function isBurner(address account) external returns (bool);

    function isAdapter(address account) external returns (bool);

    function isMinter(address account) external returns (bool);

    function isPauser(address account) external returns (bool);

    function isEditor(address account) external returns (bool);

    function isSwapper(address account) external returns (bool);
}
