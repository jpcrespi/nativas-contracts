/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./ERC1155Accessible.sol";

/**
 * @dev Offset Implementation
 */
contract ERC1155Offsetable is ERC1155Accessible {
    /**
     *
     */
    struct Offset {
        uint256 tokenId;
        uint256 value;
        uint256 date;
    }

    //
    mapping(address => Offset[]) private _offsets;
    mapping(address => uint256) private _offsetCount;

    /**
     *
     */
    function offset(
        address account,
        uint256 id,
        uint256 value,
        bytes memory data
    ) public virtual {
        require(
            _isOwnerOrApproved(account),
            "ERC1155: caller is not owner nor approved"
        );

        _burn(account, id, value, data);
        _offset(account, id, value);
    }

    /**
     *
     */
    function offsetBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory values,
        bytes memory data
    ) public virtual {
        require(
            _isOwnerOrApproved(account),
            "ERC1155: caller is not owner nor approved"
        );

        _burnBatch(account, ids, values, data);

        for (uint256 i = 0; i < ids.length; i++) {
            _offset(account, ids[i], values[i]);
        }
    }

    /**
     *
     */
    function getOffsetValue(address account, uint256 index)
        public
        view
        virtual
        returns (
            uint256 tokenId,
            uint256 value,
            uint256 date
        )
    {
        Offset memory data = _offsets[account][index];
        return (data.tokenId, data.value, data.date);
    }

    /**
     *
     */
    function getOffsetCount(address account)
        public
        view
        virtual
        returns (uint256)
    {
        return _offsetCount[account];
    }

    function _offset(
        address account,
        uint256 id,
        uint256 value
    ) internal virtual {
        _offsetCount[account]++;
        _offsets[account].push(Offset(id, value, block.timestamp));
    }
}
