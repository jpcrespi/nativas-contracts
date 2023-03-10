/// SPDX-License-Identifier: MIT
/// @by: Nativas ClimaTech
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "../../../interfaces/erc1155/IERC1155ERC20.sol";
import "../../../interfaces/erc20/IERC20Adapter.sol";
import "./ERC1155Supplyable.sol";

/**
 *
 */
contract ERC1155ERC20 is ERC1155Supplyable, IERC1155ERC20 {
    using Clones for address;

    // NativasAdapter template
    address internal _template;
    // Mapping token id to adapter address
    mapping(uint256 => address) internal _adapters;

    /**
     * @dev MUST trigger when a new adapter is created.
     */
    event AdapterCreated(uint256 indexed tokenId, address indexed adapter);

    /**
     * @dev Set NativasAdapter contract template
     */
    constructor(address template_) {
        _setTemplate(template_);
    }

    /**
     * @dev Get NativasAdapter contract template
     */
    function template() public view virtual returns (address) {
        return _template;
    }

    /**
     * @dev Get adpter contract address for token id.
     */
    function getAdapter(uint256 tokenId) public view virtual returns (address) {
        return _adapters[tokenId];
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(
        uint256 tokenId
    ) public view virtual override returns (bool) {
        return _adapters[tokenId] != address(0);
    }

    /**
     * @dev Perform tranfer from adapter contract.
     *
     * Requirements:
     *
     * - the caller MUST be the token adapter.
     */
    function safeAdapterTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        require(
            _msgSender() == _adapters[tokenId],
            "ERC1155ERC20: caller is not the token adapter"
        );
        _safeTransferFrom(from, to, tokenId, amount, data);
    }

    /**
     * @dev Create new adapter contract por token id
     */
    function _setAdapter(
        uint256 tokenId,
        string memory name,
        string memory symbol,
        uint8 decimals
    ) internal virtual {
        require(
            _template != address(0),
            "ERC1155ERC20: template is the zero address"
        );
        address adapter = _template.clone();
        IERC20Adapter(adapter).init(tokenId, name, symbol, decimals);
        _adapters[tokenId] = adapter;
        emit AdapterCreated(tokenId, adapter);
    }

    /**
     * @dev Sets the adapter template contracts
     *
     * Requirements:
     *
     * - the template address must not be address 0.
     * - tem template contract must implemente the IERC20Adapter interface
     */
    function _setTemplate(address template_) internal virtual {
        require(
            template_ != address(0),
            "ERC1155ERC20: new template is the zero address"
        );
        require(
            IERC165(template_).supportsInterface(
                type(IERC20Adapter).interfaceId
            ),
            "ERC1155ERC20: new template does not support IERC20Adapter interface"
        );
        _template = template_;
    }

    /**
     * @dev See {ERC1155-_beforeTokenTransfer}.
     *
     * Requirements:
     *
     * - the contract must not be paused.
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
        for (uint256 i = 0; i < tokenIds.length; ++i) {
            require(
                exists(tokenIds[i]) == true,
                "ERC1155ERC20: token adapter does not exist"
            );
        }
    }
}
