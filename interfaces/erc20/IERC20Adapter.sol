/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

/**
 * @dev Interface for the adapter functions from the ERC20 standard.
 */
interface IERC20Adapter {
    /**
     * @dev Initialize ERC20 contract
     */
    function init(
        uint256 id_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) external;
}
