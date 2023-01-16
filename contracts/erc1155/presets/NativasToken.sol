/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/IAccessControl.sol";
import "../../access/NativasRoles.sol";
import "../../access/Controllable.sol";
import "../extensions/ERC1155Pausable.sol";
import "../extensions/ERC1155Swappable.sol";
import "../extensions/ERC1155Offsettable.sol";
import "../extensions/ERC1155URIStorable.sol";
import "../extensions/ERC1155ERC20.sol";

/**
 * @dev Nativas ERC1155 Contract
 */
contract NativasToken is
    Controllable,
    ERC1155Pausable,
    ERC1155Swappable,
    ERC1155URIStorable,
    ERC1155ERC20
{
    constructor(
        address controller_,
        string memory uri_,
        address template_,
        address logger_
    )
        Controllable(controller_)
        ERC1155URIStorable(uri_)
        ERC1155ERC20(template_)
        ERC1155Swappable(logger_)
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
     * @dev Set token metadata
     */
    function setMetadata(
        uint256 tokenId,
        string memory name,
        string memory symbol,
        uint8 decimals,
        string memory uri,
        bool offsettable
    ) public virtual {
        setAdapter(tokenId, name, symbol, decimals);
        setOffsettable(tokenId, offsettable);
        setURI(tokenId, uri);
    }

    /**
     * @dev See {Controllable-_transferControl}.
     *
     * Requirements:
     *
     * - the caller must be admin
     * - new controller must implement IAccessControl interface
     */
    function transferControl(address controller_) public virtual {
        require(_hasRole(Roles.ADMIN_ROLE), "ERR-ERC1155N-01");
        require(controller_ != address(0), "ERR-ERC1155N-02");
        require(
            IERC165(controller_).supportsInterface(
                type(IAccessControl).interfaceId
            ),
            "ERR-ERC1155N-03"
        );
        _transferControl(controller_);
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
        uint256 tokenId,
        uint256 amount,
        bytes memory data
    ) public virtual {
        require(_hasRole(Roles.BURNER_ROLE), "ERR-ERC1155N-04");
        _safeBurn(account, tokenId, amount, data);
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
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual {
        require(_hasRole(Roles.BURNER_ROLE), "ERR-ERC1155N-05");
        _safeBurnBatch(account, tokenIds, amounts, data);
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
        uint256 tokenId,
        uint256 amount,
        bytes memory data
    ) public virtual {
        require(_hasRole(Roles.MINTER_ROLE), "ERR-ERC1155N-06");
        _mint(to, tokenId, amount, data);
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
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual {
        require(_hasRole(Roles.MINTER_ROLE), "ERR-ERC1155N-07");
        _mintBatch(to, tokenIds, amounts, data);
    }

    /**
     * @dev See {ERC1155ERC20-_setAdapter}
     *
     * Requirements:
     *
     * - the caller must be editor.
     */
    function setAdapter(
        uint256 tokenId,
        string memory name,
        string memory symbol,
        uint8 decimals
    ) public virtual {
        require(_hasRole(Roles.EDITOR_ROLE), "ERR-ERC1155N-08");
        _setAdapter(tokenId, name, symbol, decimals);
    }

    /**
     * @dev See {ERC1155ERC20-_setTemplate}
     *
     * Requirements:
     *
     * - the caller must be editor.
     */
    function setTemplate(address template_) public virtual {
        require(_hasRole(Roles.ADMIN_ROLE), "ERR-ERC1155N-09");
        _setTemplate(template_);
    }

    /**
     * @dev See {Pausable-_pause}.
     *
     * Requirements:
     *
     * - the caller must be pauser.
     */
    function pause() public virtual {
        require(_hasRole(Roles.PAUSER_ROLE), "ERR-ERC1155N-10");
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
        require(_hasRole(Roles.PAUSER_ROLE), "ERR-ERC1155N-11");
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
        require(_hasRole(Roles.EDITOR_ROLE), "ERR-ERC1155N-12");
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
        require(_hasRole(Roles.EDITOR_ROLE), "ERR-ERC1155N-13");
        _setURI(tokenId, tokenURI);
    }

    /**
     * @dev See {ERC1155Offsetter-_setOffsettable}
     *
     * Requeriments:
     *
     * - the caller must be editor
     */
    function setOffsettable(uint256 tokenId, bool enabled) public virtual {
        require(_hasRole(Roles.EDITOR_ROLE), "ERR-ERC1155N-14");
        _setOffsettable(tokenId, enabled);
    }

    /**
     * @dev See {ERC1155ERC20-_updateLogger}
     *
     * Requirements:
     *
     * - the caller must be editor.
     */
    function setLogger(address logger_) public virtual {
        require(_hasRole(Roles.ADMIN_ROLE), "ERR-ERC1155N-15");
        _setLogger(logger_);
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
        uint256 fromTokenId,
        uint256 toTokenId,
        uint256 amount,
        bytes memory data
    ) public virtual {
        require(_hasRole(Roles.SWAPPER_ROLE), "ERR-ERC1155N-16");
        _swap(account, fromTokenId, toTokenId, amount, data);
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
        uint256[] memory amounts,
        bytes memory data
    ) public virtual {
        require(_hasRole(Roles.SWAPPER_ROLE), "ERR-ERC1155N-17");
        _swapBatch(account, fromTokenIds, toTokenIds, amounts, data);
    }

    /**
     * @dev See {ERC1155-_beforeTokenTransfer}
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        bytes memory data
    )
        internal
        virtual
        override(ERC1155, ERC1155ERC20, ERC1155Pausable, ERC1155URIStorable)
    {
        super._beforeTokenTransfer(operator, from, to, tokenIds, amounts, data);
    }

    /**
     * @dev See {IAccessControl-hasRole}
     */
    function _hasRole(bytes32 role) internal virtual returns (bool) {
        return IAccessControl(controller()).hasRole(role, _msgSender());
    }
}
