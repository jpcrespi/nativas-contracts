/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-1167

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

/**
 *
 */
contract ERC1167 is Context {
    /**
     *
     */
    function deploy(address implementation)
        internal
        virtual
        returns (address instance)
    {
        return Clones.clone(implementation);
    }
}
