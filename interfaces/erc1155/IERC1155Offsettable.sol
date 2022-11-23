/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

/**
 * @dev Offset Implementation
 */
interface IERC1155Offsettable {

    /**
     * @dev See {NativasFactory-_setHolder}
     *
     * Requirements:
     *
     * - the caller must be the contract owener.
     */
    function offset(
        address account,
        uint256 tokenId,
        uint256 value,
        string memory info
    ) external;
}
