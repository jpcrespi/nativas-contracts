/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi
/// @dev https://eips.ethereum.org/EIPS/eip-1155

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

/**
 * @dev Implementation of the basic standard multi-token.
 */
contract ERC1155Base is ERC1155 {
    /**
     * @dev See {ERC1155-constructor}.
     */
    constructor() ERC1155("") {}

    /**
     * @dev See {ERC1155-isApprovedForAll}
     */
    function _isOwnerOrApproved(address account)
        internal
        view
        virtual
        returns (bool)
    {
        return
            account == _msgSender() || isApprovedForAll(account, _msgSender());
    }
}
