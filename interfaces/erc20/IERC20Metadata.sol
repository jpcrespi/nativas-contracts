/// SPDX-License-Identifier: MIT
/// @company: Nativas BCorp
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-20

pragma solidity ^0.8.0;

/**
 * @title Interface for the optional metadata functions from the ERC20 standard.
 */
interface IERC20Metadata {
    /**
     * @return name the name of the token.
     */
    function name() external view returns (string memory name);

    /**
     * @return symbol the symbol of the token.
     */
    function symbol() external view returns (string memory symbol);

    /**
     * @return decimals the number of decimals the token uses
     */
    function decimals() external view returns (uint8 decimals);
}
