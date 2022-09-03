/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

/**
 *
 */
interface IERC1155Supply {
    /**
     *
     */
    function totalSupply(uint256 id) external view returns (uint256);
}
