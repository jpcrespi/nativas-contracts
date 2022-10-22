/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 * @dev Context non-abstract implementation.
 */
contract ContextStub is Context {

}

/**
 * @dev Context test mock implementation.
 */
contract ContextMock is ContextStub {
    event Sender(address sender);
    event Data(bytes data, uint256 integerValue, string stringValue);

    function msgSender() public {
        emit Sender(_msgSender());
    }

    function msgData(uint256 integerValue, string memory stringValue) public {
        emit Data(_msgData(), integerValue, stringValue);
    }
}
