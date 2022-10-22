/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 * @dev MINTER_ROLE role to mint token supply
 */
contract MintRole is Context {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
}
