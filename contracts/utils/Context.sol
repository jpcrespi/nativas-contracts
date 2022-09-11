// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/mocks/ContextMock.sol

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 *
 */
contract ContextStub is Context {

}

/**
 *
 */
contract ContextMock is Context {
    /**
     *
     */
    event Sender(address sender);
    /**
     *
     */
    event Data(bytes data, uint256 integerValue, string stringValue);

    /**
     *
     */
    function msgSender() public {
        emit Sender(_msgSender());
    }

    /**
     *
     */
    function msgData(uint256 integerValue, string memory stringValue) public {
        emit Data(_msgData(), integerValue, stringValue);
    }
}
