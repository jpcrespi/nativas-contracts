/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 *
 */
contract HoldRole is Context {
    //
    bytes32 public constant HOLDER_ROLE = keccak256("HOLDER_ROLE");
}
