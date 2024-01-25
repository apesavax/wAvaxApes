# Solidity API

## AvaxApesMarketV2

### Sale

```solidity
event Sale(address seller, address buyer, uint256 tokenId, uint256 price)
```

### ListingCreated

```solidity
event ListingCreated(address seller, address buyer, uint256 tokenId, uint256 price)
```

### ListingCancelled

```solidity
event ListingCancelled(uint256 tokenId)
```

### OfferCreated

```solidity
event OfferCreated(address creator, uint256 tokenId, uint256 pricePerItem, uint256 deadline)
```

### OfferCanceled

```solidity
event OfferCanceled(address creator, uint256 tokenId)
```

### masterContract

```solidity
contract AvaxApesInterface masterContract
```

### wrapper

```solidity
contract WrapperInterface wrapper
```

### wrapperAddress

```solidity
address wrapperAddress
```

### _devRoyalty

```solidity
uint256 _devRoyalty
```

### _minterRoyalty

```solidity
uint256 _minterRoyalty
```

### _reflectionRoyalty

```solidity
uint256 _reflectionRoyalty
```

### _admin

```solidity
address _admin
```

### listings

```solidity
mapping(uint256 => struct AvaxApesMarketV2.Listing) listings
```

### offers

```solidity
mapping(uint256 => mapping(address => struct AvaxApesMarketV2.Offer)) offers
```

### Listing

```solidity
struct Listing {
  address seller;
  address buyer;
  uint256 tokenId;
  uint256 price;
  bool exists;
}
```

### Offer

```solidity
struct Offer {
  uint256 quantity;
  uint256 pricePerItem;
  uint256 deadline;
}
```

### offerExists

```solidity
modifier offerExists(uint256 _tokenId, address _creator)
```

### offerNotExists

```solidity
modifier offerNotExists(uint256 _tokenId, address _creator)
```

### constructor

```solidity
constructor(address AvaxApesAddress, address WrapperAddress, uint256 devRoyalty, uint256 minterRoyalty, uint256 reflectionRoyalty, address admin) public
```

### receive

```solidity
receive() external payable
```

### isTokenOwner

```solidity
modifier isTokenOwner(uint256 tokenId)
```

### createPrivateListing

```solidity
function createPrivateListing(uint256 tokenId, uint256 price, address buyer) external
```

### createListing

```solidity
function createListing(uint256 tokenId, uint256 price) external
```

### getListing

```solidity
function getListing(uint256 tokenId) external view returns (address, address, uint256, uint256, bool)
```

### cancelListing

```solidity
function cancelListing(uint256 tokenId) external
```

### buy

```solidity
function buy(uint256 tokenId) external payable
```

### setMinterRoyalty

```solidity
function setMinterRoyalty(uint256 royalty) external
```

### setDevRoyalty

```solidity
function setDevRoyalty(uint256 royalty) external
```

### setReflectionRoyalty

```solidity
function setReflectionRoyalty(uint256 royalty) external
```

### setMasterAddress

```solidity
function setMasterAddress(address masterAddress) external
```

### pause

```solidity
function pause() external
```

### unpause

```solidity
function unpause() external
```

### _getNow

```solidity
function _getNow() internal view virtual returns (uint256)
```

### createOffer

```solidity
function createOffer(uint256 _tokenId, uint256 _pricePerItem, uint256 _deadline) external
```

### cancelOffer

```solidity
function cancelOffer(uint256 _tokenId) external
```

### acceptOffer

```solidity
function acceptOffer(uint256 _tokenId, address _creator) external
```

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _tokenId | uint256 |  |
| _creator | address | Offer creator address |

## AvaxApesInterface

### ownerOf

```solidity
function ownerOf(uint256 id) public virtual returns (address)
```

### transferFrom

```solidity
function transferFrom(address from, address to, uint256 id) public virtual
```

### getApproved

```solidity
function getApproved(uint256 tokenId) public view virtual returns (address)
```

### tokenMinter

```solidity
function tokenMinter(uint256 tokenId) public view virtual returns (address)
```

### reflectToOwners

```solidity
function reflectToOwners() public payable virtual
```

## WrapperInterface

### withdraw

```solidity
function withdraw(uint256 wad) public virtual
```

