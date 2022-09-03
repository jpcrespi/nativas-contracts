/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 *
 */
contract PauseRole is Context {
    //
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
}
