# Solidity API

## MaxMinted

```solidity
error MaxMinted()
```

Error caused by trying to mint more than 10k

## TransferFailed

```solidity
error TransferFailed()
```

Error caused by failed withdrawal of AVAX

## InvalidNFT

```solidity
error InvalidNFT()
```

Error caused by trying to send an invalid NFT to contract

## ContractPaused

```solidity
error ContractPaused()
```

Error caused by trying to wrap an Ape while the contract is paused

## InvalidBps

```solidity
error InvalidBps()
```

Error caused by trying to set an invalid royalty bps

## ZeroAddress

```solidity
error ZeroAddress()
```

Error caused by trying to set the royalty address to address(0)

## wAvaxApes

### baseURI

```solidity
string baseURI
```

### royaltyBps

```solidity
uint256 royaltyBps
```

### royaltyAddress

```solidity
address royaltyAddress
```

### paused

```solidity
bool paused
```

### OG

```solidity
contract IERC721Enumerable OG
```

### ApesWrapped

```solidity
event ApesWrapped(uint256[] tokenIds)
```

### ApesUnwrapped

```solidity
event ApesUnwrapped(uint256[] tokenIds)
```

### SetBaseURI

```solidity
event SetBaseURI(string uri)
```

### SetRoyaltyAddress

```solidity
event SetRoyaltyAddress(address royaltyAddress)
```

### SetRoyaltyBps

```solidity
event SetRoyaltyBps(uint256 bps)
```

### SetPaused

```solidity
event SetPaused(bool state)
```

### ERC20Withdrawn

```solidity
event ERC20Withdrawn(address tokens, uint256 amount)
```

### AVAXWithdrawn

```solidity
event AVAXWithdrawn(uint256 amount)
```

### receive

```solidity
receive() external payable
```

### constructor

```solidity
constructor() public
```

__mintERC2309 was tested and provides significant gas savings on deploy, but caused issues with snowtrace
recognizing the minted tokens so it was decided to just use _mint._

### wrap

```solidity
function wrap(uint256[] _tokenIds) public
```

Used to wrap OG Apes. Users deposit OG NFT and recieve an ERC721A copy.

__tokenApprovals in ERC721A was modified to be internal rather than private so that it could be
used in this way. Since ERC721A has no internal _transfer function there was no way to have the contract send
an nft to caller without this modification because of lacking approvals. Approvals are cleared on transfer._

### unwrap

```solidity
function unwrap(uint256[] _tokenIds) public
```

Used to unwrap OG Apes. Users deposit their ERC721A copy and receive the original Ape back.

### getWalletOfOwnerOG

```solidity
function getWalletOfOwnerOG(address _holder) external view returns (uint256[])
```

View function that returns an array of OG Ape token ids held by an address.

_While the OG Apes are ERC721Enumerable, there is no view function to get an array of token ids.
This function prevents having the app front-end from having to call tokenOfOwnerByIndex many times to get holdings._

### tokenURI

```solidity
function tokenURI(uint256 tokenId) public view virtual returns (string)
```

View function that returns the token URI.

### royaltyInfo

```solidity
function royaltyInfo(uint256, uint256 salePrice) external view returns (address, uint256)
```

EIP2981 RoyaltyInfo

### flipPaused

```solidity
function flipPaused() public
```

Used to pause deposits. Withdrawals are unaffected.

### setRoyaltyBps

```solidity
function setRoyaltyBps(uint256 _newBps) public
```

Used to set royalty percentage

### setRoyaltyAddress

```solidity
function setRoyaltyAddress(address _newAddress) public
```

Used to set new royalty address

### updateBaseURI

```solidity
function updateBaseURI(string _newURI) public
```

Used to update base URI

### mintRemainder

```solidity
function mintRemainder() public
```

Used to mint remaining tokens to the contract

_The first 5k are minted in the constructor, which is the max allowed due to gas constraints.
Once this function is called once, it cannot be called again, capping the supply._

### emergencyWithdrawERC20

```solidity
function emergencyWithdrawERC20(address _contract) public
```

Used to withdraw ERC20 tokens that become locked in the contract.

### emergencyWithdraw

```solidity
function emergencyWithdraw() public
```

Used to withdraw AVAX that gets sent to the contract.

_AVAX will be sent to the contract via the OG Apes internal marketplace when Apes are unwrapped due
to the marketplace royalty share mechanism._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view returns (bool)
```

Support for interfaces

### onERC721Received

```solidity
function onERC721Received(address, address, uint256, bytes) external view returns (bytes4)
```

ERC721Receiver implementation

