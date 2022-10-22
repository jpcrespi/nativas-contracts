/// SPDX-License-Identifier: MIT
/// @company: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 * @dev EDITOR_ROLE role to edit token data
 */
contract EditRole is Context {
    bytes32 public constant EDITOR_ROLE = keccak256("EDITOR_ROLE");
}
