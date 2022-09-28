/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "../ERC1155Holder.sol";

/**
 *
 */
contract ERC1155HolderFactory is ERC1155Holder, Initializable {
    /**
     *
     */
    function init(
        address entity_,
        address operator_,
        uint256 id_,
        string memory name_
    ) public initializer {
        _id = id_;
        _name = name_;
        IERC1155(entity_).setApprovalForAll(operator_, true);
    }
}
