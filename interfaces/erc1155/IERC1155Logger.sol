/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

/**
 * @title
 */
interface IERC1155Logger {
    function offset(
        address account,
        uint256 tokenId,
        uint256 amount,
        string memory reason
    ) external;
}
