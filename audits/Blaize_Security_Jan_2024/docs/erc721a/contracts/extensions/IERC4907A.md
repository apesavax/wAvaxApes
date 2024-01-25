# Solidity API

## IERC4907A

_Interface of ERC4907A._

### SetUserCallerNotOwnerNorApproved

```solidity
error SetUserCallerNotOwnerNorApproved()
```

The caller must own the token or be an approved operator.

### UpdateUser

```solidity
event UpdateUser(uint256 tokenId, address user, uint64 expires)
```

_Emitted when the `user` of an NFT or the `expires` of the `user` is changed.
The zero address for user indicates that there is no user address._

### setUser

```solidity
function setUser(uint256 tokenId, address user, uint64 expires) external
```

_Sets the `user` and `expires` for `tokenId`.
The zero address indicates there is no user.

Requirements:

- The caller must own `tokenId` or be an approved operator._

### userOf

```solidity
function userOf(uint256 tokenId) external view returns (address)
```

_Returns the user address for `tokenId`.
The zero address indicates that there is no user or if the user is expired._

### userExpires

```solidity
function userExpires(uint256 tokenId) external view returns (uint256)
```

_Returns the user's expires of `tokenId`._

