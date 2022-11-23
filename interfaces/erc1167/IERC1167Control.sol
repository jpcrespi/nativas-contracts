/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

/**
 * @title 
 */
interface IERC1167Control {

    function isAdmin(
        address account
    ) external returns(bool);

    function isEditor(
        address account
    ) external returns(bool);
}
