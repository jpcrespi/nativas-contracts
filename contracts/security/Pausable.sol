/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// Note: checked

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/Pausable.sol";

/**
 * @dev Pausable non-abstract implementation.
 */
contract PausableStub is Pausable {

}

/**
 * @dev Pausable test mock implementation.
 */
contract PausableMock is PausableStub {
    uint256 public count;

    constructor() {
        count = 0;
    }

    function normalProcess() external whenNotPaused {
        count++;
    }

    function pause() external {
        _pause();
    }

    function unpause() external {
        _unpause();
    }
}
