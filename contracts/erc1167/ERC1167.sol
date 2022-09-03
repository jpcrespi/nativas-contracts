/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-1167

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";

/**
 *
 */
abstract contract ERC1167 {
    /**
     *
     */
    function _deploy(address implementation)
        internal
        virtual
        returns (address instance)
    {
        return Clones.clone(implementation);
    }
}
