/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/erc1155/IERC1155Supply.sol";
import "../ERC1155.sol";

/**
 * @dev Extension of ERC1155 that adds tracking of total supply per id.
 */
contract ERC1155Supply is ERC1155, IERC1155Supply {
    // total supply
    mapping(uint256 => uint256) internal _totalSupply;

    /**
     * @dev Total amount of tokens in with a given id.
     */
    function totalSupply(uint256 tokenId)
        public
        view
        virtual
        override
        returns (uint256 supply)
    {
        return _totalSupply[tokenId];
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 tokenId) public view virtual returns (bool) {
        return totalSupply(tokenId) > 0;
    }

    /**
     * @dev See {ERC1155-_beforeTokenTransfer}.
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override {
        super._beforeTokenTransfer(operator, from, to, tokenIds, amounts, data);
        //Mint
        if (from == address(0)) {
            for (uint256 i = 0; i < tokenIds.length; ++i) {
                _totalSupply[tokenIds[i]] += amounts[i];
            }
        }
        // Burn
        if (to == address(0)) {
            for (uint256 i = 0; i < tokenIds.length; ++i) {
                uint256 id = tokenIds[i];
                uint256 amount = amounts[i];
                require(_totalSupply[id] >= amount, "ERR-ERC1155S-01");
                unchecked {
                    _totalSupply[id] -= amount;
                }
            }
        }
    }
}
