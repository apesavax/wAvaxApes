Avax Apes Wrapper Contract

This contract is used to wrap OG ERC721Enumerable Avax Apes into a new ERC721A implementation due to issues caused by the OG contract's integration with its internal marketplace. 

Because the claimReward function in the OG contract uses getApproved() and not isApprovedForAll(), many marketplaces cannot suport the sale of these NFTs. 

Also, custodial marketplaces have issues if they do not implement a receive() function on their marketplace contract since when transferring OG Apes, internal marketplace royalty share funds may be sent to the NFT holder (in this case, the marketplace contract).

OG Apes Contract: https://snowtrace.io/address/0x6d5087B3082f73D42a32D85e38BC95dcceDe39Bb/contract/43114/code?chainId=43114

Internal Marketplace (I THINK, it isn't verified but I believe the source in the contracts folder is correct): https://snowtrace.io/address/0x3342276A93fA7a16c4D7599788C93da98eEeE13b

Auditor Notes: 
ERC721A is imported locally because a modification was made to the ERC721A contract to make _tokenApprovals internal rather than private. This was done to allow the contract to hold its own NFTs and send them to users during wrap.
