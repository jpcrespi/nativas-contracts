/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/erc1155/IERC1155Control.sol";
import "../../access/Controllable.sol";
import "../ERC1155.sol";

/**
 * ERC1155 and AccessControl implementation
 */
contract ERC1155Controllable is ERC1155, Controllable {

    /**
     * @dev See {Controllable-constructor}
     */
    constructor(address controller_) 
        Controllable(controller_) 
    {}

    /**
     * @dev
     */
    function control() internal view returns(IERC1155Control) {
        return IERC1155Control(_controller);
    } 
}
