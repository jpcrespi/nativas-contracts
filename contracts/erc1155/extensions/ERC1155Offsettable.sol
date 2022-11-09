/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./ERC1155Accessible.sol";
import "../../access/roles/EditRole.sol";

/**
 * @dev Offset Implementation
 */
contract ERC1155Offsettable is EditRole, ERC1155Accessible {
    /**
     * @dev Offset model
     */
    struct Offset {
        uint256 tokenId;
        uint256 value;
        uint256 date;
        string info;
    }

    // offset data
    mapping(address => Offset[]) private _offsets;
    mapping(address => uint256) private _offsetCount;
    mapping(uint256 => bool) private _offsettable;

    /**
     * @dev Grants `EDITOR_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(EDITOR_ROLE, _msgSender());
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
        require(_isOwnerOrApproved(account), "E0501");
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
        require(_isOwnerOrApproved(account), "E0502");

        _burnBatch(account, tokenIds, values, data);

        for (uint256 i = 0; i < tokenIds.length; i++) {
            _offset(account, tokenIds[i], values[i], infos[i]);
        }
    }

    /**
     * @dev
     */
    function getOffsetValue(address account, uint256 index)
        public
        view
        virtual
        returns (
            uint256 tokenId,
            uint256 value,
            uint256 date,
            string memory info
        )
    {
        Offset memory data = _offsets[account][index];
        return (data.tokenId, data.value, data.date, data.info);
    }

    /**
     * @dev
     */
    function getOffsetCount(address account)
        public
        view
        virtual
        returns (uint256)
    {
        return _offsetCount[account];
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
        require(_offsettable[tokenId], "E0503");
        _offsetCount[account]++;
        _offsets[account].push(Offset(tokenId, value, block.timestamp, info));
    }

    /**
     * @dev
     */
    function offsettable(uint256 tokenId) public view virtual returns (bool) {
        return _offsettable[tokenId];
    }

    /**
     * @dev
     *
     * Requeriments:
     *
     * - the caller must have the `EDITOR_ROLE`.
     */
    function setOffsettable(uint256 tokenId, bool enabled) public virtual {
        require(hasRole(EDITOR_ROLE, _msgSender()), "E0504");
        _setOffsettable(tokenId, enabled);
    }

    /**
     * @dev
     */
    function _setOffsettable(uint256 tokenId, bool enabled) public virtual {
        _offsettable[tokenId] = enabled;
    }

    /**
     * @dev
     */
    function swap(
        address account,
        uint256 fromId,
        uint256 toId,
        uint256 value,
        bytes memory data
    ) public virtual {
        require(hasRole(EDITOR_ROLE, _msgSender()), "E0505");
        require(_isOwnerOrApproved(account), "E0506");

        _swap(account, fromId, toId, value, data);
    }

    /**
     * @dev
     */
    function swapBatch(
        address account,
        uint256[] memory fromTokenIds,
        uint256[] memory toTokenIds,
        uint256[] memory values,
        bytes memory data
    ) public virtual {
        require(hasRole(EDITOR_ROLE, _msgSender()), "E0507");
        require(_isOwnerOrApproved(account), "E0508");

        _swapBatch(account, fromTokenIds, toTokenIds, values, data);
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
        require(_offsettable[fromId] == false, "E0509");
        require(_offsettable[toId] == true, "E0510");
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
            require(_offsettable[fromIds[i]] == false, "E0511");
        }
        for (uint256 i = 0; i < toIds.length; i++) {
            require(_offsettable[toIds[i]] == true, "E0512");
        }
        _burnBatch(account, fromIds, values, data);
        _mintBatch(account, toIds, values, data);
    }
}
