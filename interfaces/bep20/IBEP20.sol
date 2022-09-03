/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://docs.binance.org/smart-chain/developer/BEP20.html

pragma solidity ^0.8.0;

import "../erc20/IERC20.sol";

interface IBEP20 is IERC20 {
    /**
     * @dev Returns the bep20 token owner which is necessary for binding with bep2 token.
     *
     * NOTE - This is an extended method of EIP20.
     * Tokens which don’t implement this method will never
     * flow across the Binance Chain and Binance Smart Chain.
     */
    function getOwner() external view returns (address owner);
}
