/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";


/**
 *
 */
contract MintRole is Context {
    //
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
}
