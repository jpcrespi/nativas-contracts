/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "../../offset/NativasOffset.sol";
import "./ERC1155Burnable.sol";
import "./ERC1155Mintable.sol";

/**
 * @dev Offset Implementation
 */
contract ERC1155Offsettable is 
    ERC1155Burnable, 
    ERC1155Mintable 
{
    address internal _book;
    mapping(uint256 => bool) private _offsettable;

    constructor() {
        _book = address(new NativasOffset());
    }

    /**
     * @dev
     */
    function offset(
        address account,
        uint256 tokenId,
        uint256 value,
        string memory info,
        bytes memory data
    ) public virtual {
        require(_isOwnerOrApproved(account), "ERC1155OE01");
        _burn(account, tokenId, value, data);
        _offset(account, tokenId, value, info);
    }

    /**
     * @dev
     */
    function offsetBatch(
        address account,
        uint256[] memory tokenIds,
        uint256[] memory values,
        string[] memory infos,
        bytes memory data
    ) public virtual {
        require(_isOwnerOrApproved(account), "ERC1155OE02");
        _burnBatch(account, tokenIds, values, data);
        for (uint256 i = 0; i < tokenIds.length; i++) {
            _offset(account, tokenIds[i], values[i], infos[i]);
        }
    }

    /**
     * @dev
     */
    function offsettable(uint256 tokenId) public view virtual returns (bool) {
        return _offsettable[tokenId];
    }

     /**
     * @dev
     */
    function offsetBook() public view virtual returns(address) {
        return _book;
    }

    /**
     * @dev
     */
    function _setOffsettable(uint256 tokenId, bool enabled) internal virtual {
        _offsettable[tokenId] = enabled;
    }

    /**
     * @dev
     */
    function _swap(
        address account,
        uint256 fromId,
        uint256 toId,
        uint256 value,
        bytes memory data
    ) internal virtual {
        require(_offsettable[fromId] == false, "ERC1155OE03");
        require(_offsettable[toId] == true, "ERC1155OE04");
        _burn(account, fromId, value, data);
        _mint(account, toId, value, data);
    }

    /**
     * @dev
     */
    function _swapBatch(
        address account,
        uint256[] memory fromIds,
        uint256[] memory toIds,
        uint256[] memory values,
        bytes memory data
    ) internal virtual {
        for (uint256 i = 0; i < fromIds.length; i++) {
            require(_offsettable[fromIds[i]] == false, "ERC1155OE05");
        }
        for (uint256 i = 0; i < toIds.length; i++) {
            require(_offsettable[toIds[i]] == true, "ERC1155OE06");
        }
        _burnBatch(account, fromIds, values, data);
        _mintBatch(account, toIds, values, data);
    }

    /**
     * @dev
     */
    function _offset(
        address account,
        uint256 tokenId,
        uint256 value,
        string memory info
    ) internal virtual {
        NativasOffset(_book).offset(account, tokenId, value, info);
    }
}
