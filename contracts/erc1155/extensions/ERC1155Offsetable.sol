/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./ERC1155Accessible.sol";
import "../../access/roles/EditRole.sol";

/**
 * @dev Offset Implementation
 */
contract ERC1155Offsetable is EditRole, ERC1155Accessible {
    /**
     * @dev
     */
    struct Offset {
        uint256 tokenId;
        uint256 value;
        uint256 date;
    }

    //
    mapping(address => Offset[]) private _offsets;
    mapping(address => uint256) private _offsetCount;
    mapping(uint256 => bool) private _offsetable;

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
     * @dev
     */
    function offsetBatch(
        address account,
        uint256[] memory tokenIds,
        uint256[] memory values,
        bytes memory data
    ) public virtual {
        require(
            _isOwnerOrApproved(account),
            "ERC1155: caller is not owner nor approved"
        );

        _burnBatch(account, tokenIds, values, data);

        for (uint256 i = 0; i < tokenIds.length; i++) {
            _offset(account, tokenIds[i], values[i]);
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
            uint256 date
        )
    {
        Offset memory data = _offsets[account][index];
        return (data.tokenId, data.value, data.date);
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
        uint256 value
    ) internal virtual {
        require(
            _offsetable[tokenId],
            "ERC1155Offsetable: token is not offsetable"
        );
        _offsetCount[account]++;
        _offsets[account].push(Offset(tokenId, value, block.timestamp));
    }

    /**
     * @dev
     */
    function offsetable(uint256 tokenId) public view virtual returns (bool) {
        return _offsetable[tokenId];
    }

    /**
     * @dev
     *
     * Requeriments:
     *
     * - the caller must have the `EDITOR_ROLE`.
     */
    function setOffsetable(uint256 tokenId, bool enabled) public virtual {
        require(
            hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155Offsetable: sender does not have role"
        );
        _setOffsetable(tokenId, enabled);
    }

    /**
     * @dev
     */
    function _setOffsetable(uint256 tokenId, bool enabled) public virtual {
        _offsetable[tokenId] = enabled;
    }
}
