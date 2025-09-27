# NFTVault: A Smart Contract Project

## Project Title
**NFTVault**

## Project Description
The **NFTVault** is a foundational Solidity smart contract designed to securely hold and manage deposited Non-Fungible Tokens (NFTs) that adhere to the ERC-721 standard. It acts as a secure escrow or personal storage system, allowing users to move their NFTs off their primary wallet address and into a dedicated, contract-secured location.

## Project Vision
To create a fundamental, secure, and gas-efficient smart contract that serves as a **personal NFT cold storage solution**. The long-term vision includes expanding its utility to enable features like collateralization, leasing, or scheduled releases for the deposited tokens.

## Key Features
- **Secure Deposit:** Allows an NFT owner to transfer ownership of their NFT to the Vault contract.
- **Permissioned Withdrawal:** Ensures only the **original depositor** can withdraw their specific NFT back to their address.
- **Deposit Tracking:** A mapping system to reliably track which user deposited which NFT (by token contract address and token ID).
- **Basic Inspection:** A view function to verify the original depositor of any specific NFT held in the vault.

## Future Scope
1.  **Timed/Vested Release:** Implement a feature to lock an NFT until a specific date or time has passed.
2.  **Collateralization Logic:** Integrate functionality to treat the deposited NFT as collateral for a loan, enabling conditional withdrawal based on loan repayment.
3.  **Owner Transferability:** Add a function for the original depositor to assign the withdrawal rights to a different address (e.g., selling the 'vaulted' position).
4.  **ERC-1155 Support:** Extend the vault to support semi-fungible tokens (ERC-1155) in addition to ERC-721.
5.  **Admin/Emergency Functions:** Implement a time-locked recovery mechanism or a simple contract upgrade pattern.

## contract detail : 0x7EF2e0048f5bAeDe046f6BF797943daF4ED8CB47
