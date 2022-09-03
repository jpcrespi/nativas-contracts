/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-1167

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../ERC1167.sol";

/**
 *
 */
abstract contract ERC1167Access is Ownable, ERC1167 {
    /**
     *
     */
    function deploy(address implementation)
        public
        virtual
        returns (address instance)
    {
        require(
            owner() == _msgSender(),
            "ERC1167Access: caller is not the owner"
        );
        return _deploy(implementation);
    }
}
