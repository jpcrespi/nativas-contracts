/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC20Adapter.sol";

/**
 *
 */
contract ERC20AdapterPreset is ERC20Adapter {
    /**
     *
     */
    constructor(
        address entiry_,
        uint256 id_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) {
        _entity = entiry_;
        _id = id_;
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }
}
