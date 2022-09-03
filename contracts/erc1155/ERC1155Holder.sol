/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "../../interfaces/erc1155/IERC1155.sol";
import "../../interfaces/erc1155/IERC1155TokenReceiver.sol";

/**
 *
 */
contract ERC1155Holder is Context, ERC165, IERC1155TokenReceiver {
    /**
     * @dev Grants `ApprovalForAll` to the account that
     * deploys the contract.
     */
    constructor(address erc1155) {
        _setApprovalForAll(erc1155, _msgSender(), true);
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
        address,
        uint256,
        uint256,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    /**
     * @dev See {IERC1155TokenReceiver-onERC1155BatchReceived}.
     */
    function onERC1155BatchReceived(
        address,
        address,
        uint256[] memory,
        uint256[] memory,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

    /**
     * @dev See {IERC1155-setApprovalForAll}.
     */
    function _setApprovalForAll(
        address erc1155,
        address operator,
        bool approved
    ) internal virtual {
        require(
            IERC165(erc1155).supportsInterface(type(IERC1155).interfaceId),
            "ERC1155Holder: contract does not support IERC1155 interface"
        );
        IERC1155(erc1155).setApprovalForAll(operator, approved);
    }
}
