![Logo](https://github.com/apesavax/wAvaxApes/blob/main/logo.png)

## Introduction

The Avax Apes were the first unique PFP NFT project on Avalanche. However, being early also meant unforseen consequences of non-standard coding practices. 

A seemingly innocuous check using getApproved in the _beforeTokenTransfer function means that setApprovalForAll is not a valid method for granting approval of a user's tokens. Unfortunately, setApprovalForAll is the standard used by NFT Marketplaces since it allows the user to only need one approval transaction for an entire collection. 

## wAvax Apes

To resolve this unique approval issue and allow the open trading of Avax Apes on all marketplaces, a wrapper contract was designed. This wrapper is simple in nature, and is meant to securely store your OG Avax Ape while allowing you to freely trade a modern ERC721A copy.

At any time, users can unwrap their OG Avax Ape leaving the on-chain provenance and historical value in tact. 

A dApp to facilitate the wrapping and unwrapping of Avax Apes can be found here:

- [ApedIn](https://apedin.org)

## Authors

- [@xrpant](https://www.x.com/xrpant)

## Audits

This contract was audited by Blaize Security in January of 2024. You can view the report in this repository. (/audits/reports)

## Mainnet Deployment

This contract was deployed to the Avalanche Mainnet on 1/25/2024.

Contract Address: 0x28bE2bd3c3Af1c947431D84b74fD432faA86cdC6

Verified on:

- [Snowtrace](https://snowtrace.io/token/0x28bE2bd3c3Af1c947431D84b74fD432faA86cdC6/contract/code?chainId=43114)
- [LORE](https://skilift.io/v1/0x28be2bd3c3af1c947431d84b74fd432faa86cdc6?tab=Code)
