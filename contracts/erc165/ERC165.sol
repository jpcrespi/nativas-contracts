/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

/**
 * @dev ERC165 non-abstract implementation.
 */
contract ERC165Stub is ERC165 {

}

/**
 * @dev ERC165 test mock implementation.
 */
contract ERC165Mock is ERC165Stub {

}
