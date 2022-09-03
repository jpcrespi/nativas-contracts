/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "../../interfaces/erc1155/IERC1155TokenReceiver.sol";

contract ERC1155Common {
    using Address for address;

    /**
     *
     */
    function _asSingletonArray(uint256 element)
        internal
        pure
        returns (uint256[] memory)
    {
        uint256[] memory array = new uint256[](1);
        array[0] = element;

        return array;
    }

    /**
     *
     */
    function _doSafeTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal {
        if (to.isContract()) {
            bytes4 response = IERC1155TokenReceiver(to).onERC1155Received(
                operator,
                from,
                id,
                amount,
                data
            );
            require(
                response == IERC1155TokenReceiver.onERC1155Received.selector,
                "ERC1155: ERC1155Receiver rejected tokens"
            );
        }
    }

    /**
     *
     */
    function _doSafeBatchTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal {
        if (to.isContract()) {
            bytes4 response = IERC1155TokenReceiver(to).onERC1155BatchReceived(
                operator,
                from,
                ids,
                amounts,
                data
            );
            require(
                response == IERC1155TokenReceiver.onERC1155Received.selector,
                "ERC1155: ERC1155Receiver rejected tokens"
            );
        }
    }
}
