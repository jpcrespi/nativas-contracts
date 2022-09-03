/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 *
 */
contract BurnRole is Context {
    //
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
}
