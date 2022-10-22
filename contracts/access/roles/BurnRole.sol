/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 * @dev BURNER_ROLE role to burn token supply
 */
contract BurnRole is Context {
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
}
