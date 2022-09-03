/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./IERC1155.sol";
import "./IERC1155Supply.sol";

/**
 *
 */
interface IERC1155ERC20 is IERC1155, IERC1155Supply {
    /**
     *
     */
    function safeAdapterTransferFrom(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) external;
}
