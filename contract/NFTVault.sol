// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define the interface at the top level (outside the contract)
interface IERC721 {
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function ownerOf(uint256 tokenId) external view returns (address owner);
}

/**
 * @title NFTVault
 * @notice A basic contract to securely hold and manage deposited NFTs (ERC-721 tokens).
 */
contract NFTVault {
    // Mapping to track which users have deposited which NFTs (token address => token ID => depositor address)
    mapping(address => mapping(uint256 => address)) private depositedNFTs;

    // --- Core Functions ---

    /**
     * @notice Allows a user to deposit an NFT into the vault.
     * @dev The NFT must be approved to be spent by this vault contract
     * BEFORE calling this function.
     * @param _tokenContract The address of the NFT (ERC-721) contract.
     * @param _tokenId The unique ID of the NFT to deposit.
     */
    function depositNFT(address _tokenContract, uint256 _tokenId) public {
        // 1. Check if the caller owns the NFT
        require(IERC721(_tokenContract).ownerOf(_tokenId) == msg.sender, "NFTVault: Sender is not the owner");

        // 2. Transfer the NFT from the user to the vault contract
        IERC721(_tokenContract).safeTransferFrom(msg.sender, address(this), _tokenId);

        // 3. Record the depositor
        depositedNFTs[_tokenContract][_tokenId] = msg.sender;
    }

    /**
     * @notice Allows the original depositor to withdraw an NFT from the vault.
     * @param _tokenContract The address of the NFT (ERC-721) contract.
     * @param _tokenId The unique ID of the NFT to withdraw.
     */
    function withdrawNFT(address _tokenContract, uint256 _tokenId) public {
        // 1. Check if the caller is the original depositor
        address depositor = depositedNFTs[_tokenContract][_tokenId];
        require(depositor == msg.sender, "NFTVault: Only the original depositor can withdraw");

        // 2. Clear the mapping entry first to prevent re-entrancy issues (good practice)
        delete depositedNFTs[_tokenContract][_tokenId];

        // 3. Transfer the NFT from the vault back to the depositor
        IERC721(_tokenContract).safeTransferFrom(address(this), msg.sender, _tokenId);
    }

    /**
     * @notice Checks the original depositor of a specific NFT.
     * @param _tokenContract The address of the NFT (ERC-721) contract.
     * @param _tokenId The unique ID of the NFT.
     * @return The address of the user who originally deposited the NFT.
     */
    function checkDepositor(address _tokenContract, uint256 _tokenId) public view returns (address) {
        return depositedNFTs[_tokenContract][_tokenId];
    }
}
