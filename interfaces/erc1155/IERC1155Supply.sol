/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

/**
 * @title Extension of ERC1155 that adds tracking of total supply per id.
 */
interface IERC1155Supply {
    /**
     * Useful for scenarios where Fungible and Non-fungible tokens have to be
     * clearly identified. Note: While a totalSupply of 1 might mean the
     * corresponding is an NFT, there is no guarantees that no other token with the
     * same id are not going to be minted.
     */
    function totalSupply(uint256 id)
        external
        view
        returns (uint256 totalSupply);
}
