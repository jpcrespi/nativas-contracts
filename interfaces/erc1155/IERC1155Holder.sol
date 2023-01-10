/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
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
        address controller_,
        uint256 holderId_,
        string memory nin_,
        string memory name_
    ) external;
}
