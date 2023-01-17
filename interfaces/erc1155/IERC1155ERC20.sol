/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "./IERC1155Supplyable.sol";

/**
 * @title Extension of ERC1155 that adds backward compatibility
 */
interface IERC1155ERC20 is IERC1155, IERC1155Supplyable {
    /**
     * @dev See {IERC1155-safeTransferFrom}.
     */
    function safeAdapterTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        uint256 amount,
        bytes memory data
    ) external;
}
