/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 * @dev OFFSETER_ROLE role to burn token supply
 */
contract OffsetRole is Context {
    bytes32 public constant OFFSETER_ROLE = keccak256("OFFSETER_ROLE");
}
