/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "../../interfaces/erc1155/IERC1155TokenReceiver.sol";

/**
 * @dev Common function for ERC1155 standar.
 */
contract ERC1155Common {
    using Address for address;

    /**
     * @dev helper function to create an array from an element.
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
     * @dev transfer acceptance check.
     */
    function _doSafeTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256 tokenId,
        uint256 amount,
        bytes memory data
    ) internal {
        if (to.isContract()) {
            bytes4 response = IERC1155TokenReceiver(to).onERC1155Received(
                operator,
                from,
                tokenId,
                amount,
                data
            );
            require(
                response == IERC1155TokenReceiver.onERC1155Received.selector,
                "ERR-ERC1155C-01"
            );
        }
    }

    /**
     * @dev batch transfer acceptance check.
     */
    function _doSafeBatchTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        bytes memory data
    ) internal {
        if (to.isContract()) {
            bytes4 response = IERC1155TokenReceiver(to).onERC1155BatchReceived(
                operator,
                from,
                tokenIds,
                amounts,
                data
            );
            require(
                response ==
                    IERC1155TokenReceiver.onERC1155BatchReceived.selector,
                "ERR-ERC1155C-02"
            );
        }
    }
}
