/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-1167

pragma solidity ^0.8.0;

import "../../../interfaces/erc1155/IERC1155ERC20.sol";
import "../../erc20/ERC20Adapter.sol";
import "./ERC1167Accessible.sol";

/**
 *
 */
abstract contract ERC1167Adaptable is ERC1167Accessible {
    // ERC20Adapter template
    address internal _adapterTemplate;

    /**
     *
     */
    event AdapterCreated(uint256 indexed id, address indexed adapter);

    /**
     *
     */
    constructor() {
        _adapterTemplate = address(new ERC20Adapter());
    }

    /**
     *
     */
    function createAdapter(
        address entity,
        uint256 id,
        string memory name,
        string memory symbol,
        uint8 decimals
    ) public virtual returns (address) {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, _msgSender()),
            "ERC1167Accessible: caller is not the token adapter"
        );
        return _createAdapter(entity, id, name, symbol, decimals);
    }

    /**
     *
     */
    function _createAdapter(
        address entity,
        uint256 id,
        string memory name,
        string memory symbol,
        uint8 decimals
    ) internal virtual returns (address) {
        address adapter = deploy(_adapterTemplate);
        ERC20Adapter(adapter).setup(entity, id, name, symbol, decimals);
        IERC1155ERC20(entity).setAdapter(id, adapter);
        emit AdapterCreated(id, adapter);
        return adapter;
    }
}
