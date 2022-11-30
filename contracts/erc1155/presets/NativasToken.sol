/// SPDX-License-Identifier: MIT
/// @by: Nativas BCorp
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/erc1155/IERC1155Control.sol";
import "../../access/Controllable.sol";
import "../extensions/ERC1155Pausable.sol";
import "../extensions/ERC1155Offsettable.sol";
import "../extensions/ERC1155URIStorable.sol";
import "../extensions/ERC1155ERC20.sol";

/**
 * @dev ERC1155 preset
 */
contract NativasToken is
    Controllable,
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
        Controllable(controller_)
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
     * @dev wrap controller address into IERC1155Control interface.
     */
    function control() internal view returns(IERC1155Control) {
        return IERC1155Control(_controller);
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
     * @dev Set token metadata
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
     * @dev See {Controllable-_transferControl}.
     *
     * Requirements:
     *
     * - the caller must be admin
     */
    function transferControl(address newController) public virtual {
        require(control().isAdmin(_msgSender()), "ERC1155NE01");
        _transferControl(newController);
    }

    /**
     * @dev See {ERC1155Burnable-_safeBurn}.
     *
     * Requirements:
     *
     * - the caller must be burner.
     */
    function burn(
        address account,
        uint256 id,
        uint256 value,
        bytes memory data
    ) internal virtual {
        require(control().isBurner(_msgSender()), "ERC1155NE02");
        _safeBurn(account, id, value, data);
    }

    /**
     * @dev See {ERC1155Burnable-_safeBurnBatch}.
     *
     * Requirements:
     *
     * - the caller must be burner.
     */
    function burnBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory values,
        bytes memory data
    ) internal virtual {
        require(control().isBurner(_msgSender()), "ERC1155NE03");
        _safeBurnBatch(account, ids, values, data);
    }

    /**
     * @dev See {ERC1155Mintable-_mint}.
     *
     * Requirements:
     *
     * - the caller must be minter.
     */
    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual {
        require(control().isMinter(_msgSender()), "ERC1155NE04");
        _mint(to, id, amount, data);
    }

    /**
     * @dev See {ERC1155Mintable-_mintBatch}.
     *
     * Requirements:
     *
     * - the caller must be minter.
     */
    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual {
        require(control().isMinter( _msgSender()), "ERC1155NE05");
        _mintBatch(to, ids, amounts, data);
    }

    /**
     * @dev See {ERC1155ERC20-_setAdapter}
     *
     * Requirements:
     *
     * - the caller must be adapter.
     */
    function setAdapter(
        uint256 id,
        string memory name,
        string memory symbol,
        uint8 decimals
    ) public virtual {
        require(control().isAdapter(_msgSender()), "ERC1155NE06");
        _setAdapter(id, name, symbol, decimals);
    }

    /**
     * @dev See {Pausable-_pause}.
     *
     * Requirements:
     *
     * - the caller must be pauser.
     */
    function pause() public virtual {
        require(control().isPauser(_msgSender()), "ERC1155NE07");
        _pause();
    }

    /**
     * @dev See {Pausable-_unpause}.
     *
     * Requirements:
     *
     * - the caller must be pauser.
     */
    function unpause() public virtual {
        require(control().isPauser(_msgSender()), "ERC1155NE08");
        _unpause();
    }

    /**
     * @dev See {ERC1155URIStorable-_setBaseURI}
     *
     * Requeriments:
     *
     * - the caller must be editor
     */
    function setBaseURI(string memory baseURI) public virtual {
        require(control().isEditor(_msgSender()), "ERC1155NE09");
        _setBaseURI(baseURI);
    }

    /**
     * @dev See {ERC1155URIStorable-_setURI}
     *
     * Requeriments:
     *
     * - the caller must be editor.
     */
    function setURI(uint256 tokenId, string memory tokenURI) public virtual {
        require(control().isEditor(_msgSender()), "ERC1155NE10");
        _setURI(tokenId, tokenURI);
    }

    /**
     * @dev See {ERC1155Offsetter-_setOffsettable}
     *
     * Requeriments:
     *
     * - the caller must be offsetter
     */
    function setOffsettable(uint256 tokenId, bool enabled) public virtual {
        require(control().isOffsetter(_msgSender()), "ERC1155NE11");
        _setOffsettable(tokenId, enabled);
    }

    /**
     * @dev See {ERC1155Offsetter-_swap}
     *
     * Requeriments:
     *
     * - the caller must be offsetter
     */
    function swap(
        address account,
        uint256 fromId,
        uint256 toId,
        uint256 value,
        bytes memory data
    ) public virtual {
        require(control().isOffsetter(_msgSender()), "ERC1155NE12");
        _swap(account, fromId, toId, value, data);
    }

    /**
     * @dev See {ERC1155Offsetter-_swapBatch}
     *
     * Requeriments:
     *
     * - the caller must be offsetter
     */
    function swapBatch(
        address account,
        uint256[] memory fromTokenIds,
        uint256[] memory toTokenIds,
        uint256[] memory values,
        bytes memory data
    ) public virtual {
        require(control().isOffsetter(_msgSender()), "ERC1155NE13");
        _swapBatch(account, fromTokenIds, toTokenIds, values, data);
    }

    /**
     * @dev See {ERC1155-_beforeTokenTransfer}
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override(
        ERC1155, 
        ERC1155ERC20,
        ERC1155Pausable,
        ERC1155URIStorable) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
