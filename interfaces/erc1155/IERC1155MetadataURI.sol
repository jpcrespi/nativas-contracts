/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev https://eips.ethereum.org/EIPS/eip-1155
/// Note: OK

pragma solidity ^0.8.0;

/**
 * @title Interface of the optional ERC1155MetadataExtension interface
 * Note: The ERC-165 identifier for this interface is 0x0e89341c.
 */
interface IERC1155MetadataURI {
    /**
     * @notice A distinct Uniform Resource Identifier (URI) for a given token.
     * @dev URIs are defined in RFC 3986.
     * The URI MUST point to a JSON file that conforms to the "ERC-1155 Metadata URI JSON Schema".
     * @return uri string
     */
    function uri(uint256 id) external view returns (string memory uri);
}
