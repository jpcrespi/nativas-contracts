// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/security/Pausable.sol

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/Pausable.sol";

/**
 *
 */
contract PausableMock is Pausable {
    /**
     *
     */
    function pause() external {
        _pause();
    }

    /**
     *
     */
    function unpause() external {
        _unpause();
    }
}
