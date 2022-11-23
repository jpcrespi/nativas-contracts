/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 * @dev Contract module which provides a basic access control mechanism.
 */
contract Controllable is Context {
    
    address internal _controller;
    
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
     * @dev Transfers control of the contract to a new account (`newController`).
     * Can only be called by the current accessor.
     */
    function transferControl(address newController) public virtual {
        require(controller() == _msgSender(), "E0901");
        require(newController != address(0), "E0902");
        _transferControl(newController);
    }

    /**
     * @dev Transfers control of the contract to a new account (`newController`).
     * Internal function without access restriction.
     */
    function _transferControl(address newController) internal virtual {
        address oldController = _controller;
        _controller = newController;
        emit ControlTransferred(oldController, newController);
    }
}
