/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 * @dev Contract module which provides a basic access control mechanism.
 */
contract Controllable is Context {
    address private _controller;

    event ControlTransferred(
        address indexed oldController,
        address indexed newControllerr
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor(address controller_) {
        _transferControl(controller_);
    }

    /**
     * @dev Returns the address of the current accessor.
     */
    function controller() public view virtual returns (address) {
        return _controller;
    }

    /**
     * @dev Transfers control of the contract to a new account (`controller_`).
     * Can only be called by the current controller.
     *
     * NOTE: Renouncing control will leave the contract without a controller,
     * thereby removing any functionality that is only available to the controller.
     */
    function _transferControl(address controller_) internal virtual {
        address oldController = _controller;
        _controller = controller_;
        emit ControlTransferred(oldController, controller_);
    }
}
