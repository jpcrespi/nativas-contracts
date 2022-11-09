/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

/**
 * @title Extension of ERC1155 that adds backward compatibility
 */
interface IERC1155Holder {
    /**
     * @dev Initialize contract
     */
    function init(
        address entity_,
        address operator_,
        uint256 id_,
        string memory name_
    ) external;
}
