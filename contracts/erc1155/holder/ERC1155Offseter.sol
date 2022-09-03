/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "../../../interfaces/erc1155/IERC1155.sol";
import "../../../interfaces/erc1155/IERC1155TokenReceiver.sol";
import "../../../interfaces/erc1155/IERC1155Burnable.sol";

/**
 *
 */
contract ERC1155Offseter is Context, ERC165, IERC1155TokenReceiver {
    //
    address internal _entity;

    /**
     * @dev Grants `ApprovalForAll` to the account that
     * deploys the contract.
     */
    constructor(address entity_) {
        _entity = entity_;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override
        returns (bool)
    {
        return
            interfaceId == type(IERC1155TokenReceiver).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC1155TokenReceiver-onERC1155Received}.
     */
    function onERC1155Received(
        address,
        address from,
        uint256 id,
        uint256 value,
        bytes memory
    ) public virtual override returns (bytes4) {
        require(
            _msgSender() == _entity,
            "ERC1155: caller is not the token entity"
        );
        IERC1155Burnable(_entity).burn(from, id, value);
        return this.onERC1155Received.selector;
    }

    /**
     * @dev See {IERC1155TokenReceiver-onERC1155BatchReceived}.
     */
    function onERC1155BatchReceived(
        address,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes memory
    ) public virtual override returns (bytes4) {
        require(
            _msgSender() == _entity,
            "ERC1155: caller is not the token entity"
        );
        IERC1155Burnable(_entity).burnBatch(from, ids, values);
        return this.onERC1155BatchReceived.selector;
    }
}
