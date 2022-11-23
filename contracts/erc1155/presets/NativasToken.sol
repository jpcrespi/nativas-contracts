/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../extensions/ERC1155Controllable.sol";
import "../extensions/ERC1155Pausable.sol";
import "../extensions/ERC1155Offsettable.sol";
import "../extensions/ERC1155URIStorable.sol";
import "../extensions/ERC1155ERC20.sol";

/**
 * @dev ERC1155 preset
 */
contract NativasToken is
    ERC1155Controllable,
    ERC1155Pausable,
    ERC1155Offsettable,
    ERC1155URIStorable,
    ERC1155ERC20
{
    constructor(
        address controller_, 
        string memory uri_, 
        address template_
    )
        ERC1155Controllable(controller_)
        ERC1155URIStorable(uri_)
        ERC1155ERC20(template_)
    {}

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155, ERC1155URIStorable)
        returns (bool success)
    {
        return super.supportsInterface(interfaceId);
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 tokenId)
        public
        view
        virtual
        override(ERC1155ERC20, ERC1155URIStorable)
        returns (bool)
    {
        return super.exists(tokenId);
    }

    /**
     *
     */
    function setMetadata(
        uint256 id,
        string memory name,
        string memory symbol,
        uint8 decimals,
        string memory uri,
        bool offsettable
    ) public virtual {
        setAdapter(id, name, symbol, decimals);
        setOffsettable(id, offsettable);
        setURI(id, uri);
    }

    /**
     * @dev See {Controllable-_safeTransferControl}.
     *
     * Requirements:
     *
     * - the caller must have the `DEFAULT_ADMIN_ROLE`.
     */
    function transferControl(address newController) public virtual {
        require(control().isAdmin(_msgSender()), "E0201");
        _safeTransferControl(newController);
    }

    /**
     * @dev See {ERC1155Accessible-_burn}.
     *
     * Requirements:
     *
     * - the caller must have the `BURNER_ROLE`.
     */
    function burn(
        address account,
        uint256 id,
        uint256 value,
        bytes memory data
    ) internal virtual {
        require(control().isBurner(_msgSender()), "E0201");
        _safeBurn(account, id, value, data);
    }

    /**
     * @dev See {ERC1155Accessible-_burnBatch}.
     *
     * Requirements:
     *
     * - the caller must have the `BURNER_ROLE`.
     */
    function burnBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory values,
        bytes memory data
    ) internal virtual {
        require(control().isBurner(_msgSender()), "E0203");
        _safeBurnBatch(account, ids, values, data);
    }

    /**
     * @dev See {ERC1155Accessible-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual {
        require(control().isMinter(_msgSender()), "E0401");
        _mint(to, id, amount, data);
    }

    /**
     * @dev See {ERC1155Accessible-_mintBatch}.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual {
        require(control().isMinter( _msgSender()), "E0402");
        _mintBatch(to, ids, amounts, data);
    }

    /**
     * @dev See {ERC1155ERC20-_setAdapter}
     *
     * Requirements:
     *
     * - the caller must have the `EDITOR_ROLE`.
     */
    function setAdapter(
        uint256 id,
        string memory name,
        string memory symbol,
        uint8 decimals
    ) public virtual {
        require(control().isAdapter(_msgSender()), "E0301");
        _setAdapter(id, name, symbol, decimals);
    }

    /**
     * @dev Pauses all token transfers.
     *
     * See {Pausable-_pause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function pause() public virtual {
        require(control().isPauser(_msgSender()), "E0601");
        _pause();
    }

    /**
     * @dev Unpauses all token transfers.
     *
     * See {Pausable-_unpause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function unpause() public virtual {
        require(control().isPauser(_msgSender()), "E0602");
        _unpause();
    }

    /**
     * @dev See {ERC1155URIStorable-_setBaseURI}
     *
     * Requeriments:
     *
     * - the caller must have the `EDITOR_ROLE`.
     */
    function setBaseURI(string memory baseURI) public virtual {
        require(control().isEditor(_msgSender()), "E0801");
        _setBaseURI(baseURI);
    }

    /**
     * @dev See {ERC1155URIStorable-_setURI}
     *
     * Requeriments:
     *
     * - the caller must have the `EDITOR_ROLE`.
     */
    function setURI(uint256 tokenId, string memory tokenURI) public virtual {
        require(control().isEditor(_msgSender()), "E0802");
        _setURI(tokenId, tokenURI);
    }

    /**
     * @dev
     *
     * Requeriments:
     *
     * - the caller must have the `OFFSETER_ROLE`.
     */
    function setOffsettable(uint256 tokenId, bool enabled) public virtual {
        require(control().isOffsetter(_msgSender()), "E0504");
        _setOffsettable(tokenId, enabled);
    }

    /**
     * @dev
     *
     * Requeriments:
     *
     * - the caller must have the `OFFSETER_ROLE`.
     */
    function setOffsetCatalog(address catalog_) public virtual {
        require(control().isOffsetter(_msgSender()), "E0504");
        _setOffsetCatalog(catalog_);
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
        require(control().isOffsetter(_msgSender()), "E0505");
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
        require(control().isOffsetter(_msgSender()), "E0507");
        _swapBatch(account, fromTokenIds, toTokenIds, values, data);
    }

    /**
     *
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override(ERC1155, ERC1155Pausable, ERC1155Supply) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
