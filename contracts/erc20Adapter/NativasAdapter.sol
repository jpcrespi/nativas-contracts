/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "../../interfaces/erc1155/IERC1155ERC20.sol";
import "../../interfaces/erc20/IERC20.sol";
import "../../interfaces/erc20/IERC20Adapter.sol";
import "../../interfaces/erc20/IERC20Metadata.sol";

/**
 * @title ERC20 inplementation that adds backward compatibility
 */
contract NativasAdapter is
    Context,
    Initializable,
    ERC165,
    IERC20,
    IERC20Adapter,
    IERC20Metadata
{
    // IERC1155ERC20
    IERC1155ERC20 internal _entity;
    // Token indentifier
    uint256 internal _tokenId;
    // Token name
    string internal _name;
    // Token symbol
    string internal _symbol;
    // Token decimals
    uint8 internal _decimals;

    /**
     * @dev See {NativasAdapter-init}
     */
    constructor(
        uint256 tokenId_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) {
        init(tokenId_, name_, symbol_, decimals_);
    }

    /**
     * @dev Initialize contract
     */
    function init(
        uint256 tokenId_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) public override initializer {
        _entity = IERC1155ERC20(_msgSender());
        _tokenId = tokenId_;
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override
        returns (bool)
    {
        return
            interfaceId == type(IERC20).interfaceId ||
            interfaceId == type(IERC20Adapter).interfaceId ||
            interfaceId == type(IERC20Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev ERC1155 token address.
     */
    function entity() public view virtual returns (address) {
        return address(_entity);
    }

    /**
     * @dev ERC1155 token indentifier.
     */
    function id() public view virtual returns (uint256) {
        return _tokenId;
    }

    /**
     * @dev See {IERC20-name}.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev See {IERC20-symbol}.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev See {IERC20-decimals}.
     */
    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _entity.totalSupply(_tokenId);
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account)
        public
        view
        virtual
        override
        returns (uint256)
    {
        return _entity.balanceOf(account, _tokenId);
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address, address)
        public
        view
        virtual
        override
        returns (uint256)
    {
        return 0;
    }

    /**
     * @dev See {IERC20-approve}.
     */
    function approve(address, uint256) public virtual override returns (bool) {
        require(false);
        return false;
    }

    /**
     * @dev See {IERC20-transfer}.
     */
    function transfer(address to, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     */
    function transferFrom(
        address,
        address,
        uint256
    ) public virtual override returns (bool) {
        require(false);
        return false;
    }

    /**
     * @dev See {IERC1155ERC20-safeAdapterTransferFrom}
     */
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        _entity.safeAdapterTransferFrom(from, to, _tokenId, amount, "");
    }
}
