# Solidity API

## IERC165

_Interface of the ERC165 standard, as defined in the
https://eips.ethereum.org/EIPS/eip-165[EIP].

Implementers can declare support of contract interfaces, which can then be
queried by others ({ERC165Checker}).

For an implementation, see {ERC165}._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```

_Returns true if this contract implements the interface defined by
`interfaceId`. See the corresponding
https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
to learn more about how these ids are created.

This function call must use less than 30 000 gas._

## IERC721

_Required interface of an ERC721 compliant contract._

### Transfer

```solidity
event Transfer(address from, address to, uint256 tokenId)
```

_Emitted when `tokenId` token is transferred from `from` to `to`._

### Approval

```solidity
event Approval(address owner, address approved, uint256 tokenId)
```

_Emitted when `owner` enables `approved` to manage the `tokenId` token._

### ApprovalForAll

```solidity
event ApprovalForAll(address owner, address operator, bool approved)
```

_Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets._

### balanceOf

```solidity
function balanceOf(address owner) external view returns (uint256 balance)
```

_Returns the number of tokens in ``owner``'s account._

### ownerOf

```solidity
function ownerOf(uint256 tokenId) external view returns (address owner)
```

_Returns the owner of the `tokenId` token.

Requirements:

- `tokenId` must exist._

### safeTransferFrom

```solidity
function safeTransferFrom(address from, address to, uint256 tokenId) external
```

_Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
are aware of the ERC721 protocol to prevent tokens from being forever locked.

Requirements:

- `from` cannot be the zero address.
- `to` cannot be the zero address.
- `tokenId` token must exist and be owned by `from`.
- If the caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}.
- If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.

Emits a {Transfer} event._

### transferFrom

```solidity
function transferFrom(address from, address to, uint256 tokenId) external
```

_Transfers `tokenId` token from `from` to `to`.

WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.

Requirements:

- `from` cannot be the zero address.
- `to` cannot be the zero address.
- `tokenId` token must be owned by `from`.
- If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.

Emits a {Transfer} event._

### approve

```solidity
function approve(address to, uint256 tokenId) external
```

_Gives permission to `to` to transfer `tokenId` token to another account.
The approval is cleared when the token is transferred.

Only a single account can be approved at a time, so approving the zero address clears previous approvals.

Requirements:

- The caller must own the token or be an approved operator.
- `tokenId` must exist.

Emits an {Approval} event._

### getApproved

```solidity
function getApproved(uint256 tokenId) external view returns (address operator)
```

_Returns the account approved for `tokenId` token.

Requirements:

- `tokenId` must exist._

### setApprovalForAll

```solidity
function setApprovalForAll(address operator, bool _approved) external
```

_Approve or remove `operator` as an operator for the caller.
Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.

Requirements:

- The `operator` cannot be the caller.

Emits an {ApprovalForAll} event._

### isApprovedForAll

```solidity
function isApprovedForAll(address owner, address operator) external view returns (bool)
```

_Returns if the `operator` is allowed to manage all of the assets of `owner`.

See {setApprovalForAll}_

### safeTransferFrom

```solidity
function safeTransferFrom(address from, address to, uint256 tokenId, bytes data) external
```

_Safely transfers `tokenId` token from `from` to `to`.

Requirements:

- `from` cannot be the zero address.
- `to` cannot be the zero address.
- `tokenId` token must exist and be owned by `from`.
- If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
- If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.

Emits a {Transfer} event._

## IERC721Receiver

_Interface for any contract that wants to support safeTransfers
from ERC721 asset contracts._

### onERC721Received

```solidity
function onERC721Received(address operator, address from, uint256 tokenId, bytes data) external returns (bytes4)
```

_Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
by `operator` from `from`, this function is called.

It must return its Solidity selector to confirm the token transfer.
If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.

The selector can be obtained in Solidity with `IERC721.onERC721Received.selector`._

## IERC721Metadata

_See https://eips.ethereum.org/EIPS/eip-721_

### name

```solidity
function name() external view returns (string)
```

_Returns the token collection name._

### symbol

```solidity
function symbol() external view returns (string)
```

_Returns the token collection symbol._

### tokenURI

```solidity
function tokenURI(uint256 tokenId) external view returns (string)
```

_Returns the Uniform Resource Identifier (URI) for `tokenId` token._

## IERC721Enumerable

_See https://eips.ethereum.org/EIPS/eip-721_

### totalSupply

```solidity
function totalSupply() external view returns (uint256)
```

_Returns the total amount of tokens stored by the contract._

### tokenOfOwnerByIndex

```solidity
function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId)
```

_Returns a token ID owned by `owner` at a given `index` of its token list.
Use along with {balanceOf} to enumerate all of ``owner``'s tokens._

### tokenByIndex

```solidity
function tokenByIndex(uint256 index) external view returns (uint256)
```

_Returns a token ID at a given `index` of all the tokens stored by the contract.
Use along with {totalSupply} to enumerate all tokens._

## Address

_Collection of functions related to the address type_

### isContract

```solidity
function isContract(address account) internal view returns (bool)
```

_Returns true if `account` is a contract.

[IMPORTANT]
====
It is unsafe to assume that an address for which this function returns
false is an externally-owned account (EOA) and not a contract.

Among others, `isContract` will return false for the following
types of addresses:

 - an externally-owned account
 - a contract in construction
 - an address where a contract will be created
 - an address where a contract lived, but was destroyed
====_

### sendValue

```solidity
function sendValue(address payable recipient, uint256 amount) internal
```

_Replacement for Solidity's `transfer`: sends `amount` wei to
`recipient`, forwarding all available gas and reverting on errors.

https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
of certain opcodes, possibly making contracts go over the 2300 gas limit
imposed by `transfer`, making them unable to receive funds via
`transfer`. {sendValue} removes this limitation.

https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].

IMPORTANT: because control is transferred to `recipient`, care must be
taken to not create reentrancy vulnerabilities. Consider using
{ReentrancyGuard} or the
https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern]._

### functionCall

```solidity
function functionCall(address target, bytes data) internal returns (bytes)
```

_Performs a Solidity function call using a low level `call`. A
plain`call` is an unsafe replacement for a function call: use this
function instead.

If `target` reverts with a revert reason, it is bubbled up by this
function (like regular Solidity function calls).

Returns the raw returned data. To convert to the expected return value,
use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].

Requirements:

- `target` must be a contract.
- calling `target` with `data` must not revert.

_Available since v3.1.__

### functionCall

```solidity
function functionCall(address target, bytes data, string errorMessage) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
`errorMessage` as a fallback revert reason when `target` reverts.

_Available since v3.1.__

### functionCallWithValue

```solidity
function functionCallWithValue(address target, bytes data, uint256 value) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
but also transferring `value` wei to `target`.

Requirements:

- the calling contract must have an ETH balance of at least `value`.
- the called Solidity function must be `payable`.

_Available since v3.1.__

### functionCallWithValue

```solidity
function functionCallWithValue(address target, bytes data, uint256 value, string errorMessage) internal returns (bytes)
```

_Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
with `errorMessage` as a fallback revert reason when `target` reverts.

_Available since v3.1.__

### functionStaticCall

```solidity
function functionStaticCall(address target, bytes data) internal view returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
but performing a static call.

_Available since v3.3.__

### functionStaticCall

```solidity
function functionStaticCall(address target, bytes data, string errorMessage) internal view returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
but performing a static call.

_Available since v3.3.__

### functionDelegateCall

```solidity
function functionDelegateCall(address target, bytes data) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
but performing a delegate call.

_Available since v3.4.__

### functionDelegateCall

```solidity
function functionDelegateCall(address target, bytes data, string errorMessage) internal returns (bytes)
```

_Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
but performing a delegate call.

_Available since v3.4.__

### _verifyCallResult

```solidity
function _verifyCallResult(bool success, bytes returndata, string errorMessage) private pure returns (bytes)
```

## Context

### _msgSender

```solidity
function _msgSender() internal view virtual returns (address)
```

### _msgData

```solidity
function _msgData() internal view virtual returns (bytes)
```

## Strings

_String operations._

### alphabet

```solidity
bytes16 alphabet
```

### toString

```solidity
function toString(uint256 value) internal pure returns (string)
```

_Converts a `uint256` to its ASCII `string` decimal representation._

### toHexString

```solidity
function toHexString(uint256 value) internal pure returns (string)
```

_Converts a `uint256` to its ASCII `string` hexadecimal representation._

### toHexString

```solidity
function toHexString(uint256 value, uint256 length) internal pure returns (string)
```

_Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length._

## ERC165

_Implementation of the {IERC165} interface.

Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
for the additional interface id that will be supported. For example:

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
    return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
}
```

Alternatively, {ERC165Storage} provides an easier to use but more expensive implementation._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}._

## ERC721

_Implementation of https://eips.ethereum.org/EIPS/eip-721[ERC721] Non-Fungible Token Standard, including
the Metadata extension, but not including the Enumerable extension, which is available separately as
{ERC721Enumerable}._

### _name

```solidity
string _name
```

### _symbol

```solidity
string _symbol
```

### _owners

```solidity
mapping(uint256 => address) _owners
```

### _balances

```solidity
mapping(address => uint256) _balances
```

### _tokenApprovals

```solidity
mapping(uint256 => address) _tokenApprovals
```

### _operatorApprovals

```solidity
mapping(address => mapping(address => bool)) _operatorApprovals
```

### constructor

```solidity
constructor(string name_, string symbol_) public
```

_Initializes the contract by setting a `name` and a `symbol` to the token collection._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}._

### balanceOf

```solidity
function balanceOf(address owner) public view virtual returns (uint256)
```

_See {IERC721-balanceOf}._

### ownerOf

```solidity
function ownerOf(uint256 tokenId) public view virtual returns (address)
```

_See {IERC721-ownerOf}._

### name

```solidity
function name() public view virtual returns (string)
```

_See {IERC721Metadata-name}._

### symbol

```solidity
function symbol() public view virtual returns (string)
```

_See {IERC721Metadata-symbol}._

### tokenURI

```solidity
function tokenURI(uint256 tokenId) public view virtual returns (string)
```

_See {IERC721Metadata-tokenURI}._

### _baseURI

```solidity
function _baseURI() internal view virtual returns (string)
```

_Base URI for computing {tokenURI}. Empty by default, can be overriden
in child contracts._

### approve

```solidity
function approve(address to, uint256 tokenId) public virtual
```

_See {IERC721-approve}._

### getApproved

```solidity
function getApproved(uint256 tokenId) public view virtual returns (address)
```

_See {IERC721-getApproved}._

### setApprovalForAll

```solidity
function setApprovalForAll(address operator, bool approved) public virtual
```

_See {IERC721-setApprovalForAll}._

### isApprovedForAll

```solidity
function isApprovedForAll(address owner, address operator) public view virtual returns (bool)
```

_See {IERC721-isApprovedForAll}._

### transferFrom

```solidity
function transferFrom(address from, address to, uint256 tokenId) public virtual
```

_See {IERC721-transferFrom}._

### safeTransferFrom

```solidity
function safeTransferFrom(address from, address to, uint256 tokenId) public virtual
```

_See {IERC721-safeTransferFrom}._

### safeTransferFrom

```solidity
function safeTransferFrom(address from, address to, uint256 tokenId, bytes _data) public virtual
```

_See {IERC721-safeTransferFrom}._

### _safeTransfer

```solidity
function _safeTransfer(address from, address to, uint256 tokenId, bytes _data) internal virtual
```

_Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
are aware of the ERC721 protocol to prevent tokens from being forever locked.

`_data` is additional data, it has no specified format and it is sent in call to `to`.

This internal function is equivalent to {safeTransferFrom}, and can be used to e.g.
implement alternative mechanisms to perform token transfer, such as signature-based.

Requirements:

- `from` cannot be the zero address.
- `to` cannot be the zero address.
- `tokenId` token must exist and be owned by `from`.
- If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.

Emits a {Transfer} event._

### _exists

```solidity
function _exists(uint256 tokenId) internal view virtual returns (bool)
```

_Returns whether `tokenId` exists.

Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.

Tokens start existing when they are minted (`_mint`),
and stop existing when they are burned (`_burn`)._

### _isApprovedOrOwner

```solidity
function _isApprovedOrOwner(address spender, uint256 tokenId) internal view virtual returns (bool)
```

_Returns whether `spender` is allowed to manage `tokenId`.

Requirements:

- `tokenId` must exist._

### _safeMint

```solidity
function _safeMint(address to, uint256 tokenId) internal virtual
```

_Safely mints `tokenId` and transfers it to `to`.

Requirements:

- `tokenId` must not exist.
- If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.

Emits a {Transfer} event._

### _safeMint

```solidity
function _safeMint(address to, uint256 tokenId, bytes _data) internal virtual
```

_Same as {xref-ERC721-_safeMint-address-uint256-}[`_safeMint`], with an additional `data` parameter which is
forwarded in {IERC721Receiver-onERC721Received} to contract recipients._

### _mint

```solidity
function _mint(address to, uint256 tokenId) internal virtual
```

_Mints `tokenId` and transfers it to `to`.

WARNING: Usage of this method is discouraged, use {_safeMint} whenever possible

Requirements:

- `tokenId` must not exist.
- `to` cannot be the zero address.

Emits a {Transfer} event._

### _burn

```solidity
function _burn(uint256 tokenId) internal virtual
```

_Destroys `tokenId`.
The approval is cleared when the token is burned.

Requirements:

- `tokenId` must exist.

Emits a {Transfer} event._

### _transfer

```solidity
function _transfer(address from, address to, uint256 tokenId) internal virtual
```

_Transfers `tokenId` from `from` to `to`.
 As opposed to {transferFrom}, this imposes no restrictions on msg.sender.

Requirements:

- `to` cannot be the zero address.
- `tokenId` token must be owned by `from`.

Emits a {Transfer} event._

### _approve

```solidity
function _approve(address to, uint256 tokenId) internal virtual
```

_Approve `to` to operate on `tokenId`

Emits a {Approval} event._

### _checkOnERC721Received

```solidity
function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes _data) private returns (bool)
```

_Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
The call is not executed if the target address is not a contract._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | address representing the previous owner of the given token ID |
| to | address | target address that will receive the tokens |
| tokenId | uint256 | uint256 ID of the token to be transferred |
| _data | bytes | bytes optional data to send along with the call |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | bool whether the call correctly returned the expected magic value |

### _beforeTokenTransfer

```solidity
function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual
```

_Hook that is called before any token transfer. This includes minting
and burning.

Calling conditions:

- When `from` and `to` are both non-zero, ``from``'s `tokenId` will be
transferred to `to`.
- When `from` is zero, `tokenId` will be minted for `to`.
- When `to` is zero, ``from``'s `tokenId` will be burned.
- `from` cannot be the zero address.
- `to` cannot be the zero address.

To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks]._

## ERC721Enumerable

_This implements an optional extension of {ERC721} defined in the EIP that adds
enumerability of all the token ids in the contract as well as all token ids owned by each
account._

### _ownedTokens

```solidity
mapping(address => mapping(uint256 => uint256)) _ownedTokens
```

### _ownedTokensIndex

```solidity
mapping(uint256 => uint256) _ownedTokensIndex
```

### _allTokens

```solidity
uint256[] _allTokens
```

### _allTokensIndex

```solidity
mapping(uint256 => uint256) _allTokensIndex
```

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}._

### tokenOfOwnerByIndex

```solidity
function tokenOfOwnerByIndex(address owner, uint256 index) public view virtual returns (uint256)
```

_See {IERC721Enumerable-tokenOfOwnerByIndex}._

### totalSupply

```solidity
function totalSupply() public view virtual returns (uint256)
```

_See {IERC721Enumerable-totalSupply}._

### tokenByIndex

```solidity
function tokenByIndex(uint256 index) public view virtual returns (uint256)
```

_See {IERC721Enumerable-tokenByIndex}._

### _beforeTokenTransfer

```solidity
function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual
```

_Hook that is called before any token transfer. This includes minting
and burning.

Calling conditions:

- When `from` and `to` are both non-zero, ``from``'s `tokenId` will be
transferred to `to`.
- When `from` is zero, `tokenId` will be minted for `to`.
- When `to` is zero, ``from``'s `tokenId` will be burned.
- `from` cannot be the zero address.
- `to` cannot be the zero address.

To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks]._

### _addTokenToOwnerEnumeration

```solidity
function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private
```

_Private function to add a token to this extension's ownership-tracking data structures._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| to | address | address representing the new owner of the given token ID |
| tokenId | uint256 | uint256 ID of the token to be added to the tokens list of the given address |

### _addTokenToAllTokensEnumeration

```solidity
function _addTokenToAllTokensEnumeration(uint256 tokenId) private
```

_Private function to add a token to this extension's token tracking data structures._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | uint256 ID of the token to be added to the tokens list |

### _removeTokenFromOwnerEnumeration

```solidity
function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId) private
```

_Private function to remove a token from this extension's ownership-tracking data structures. Note that
while the token is not assigned a new owner, the `_ownedTokensIndex` mapping is _not_ updated: this allows for
gas optimizations e.g. when performing a transfer operation (avoiding double writes).
This has O(1) time complexity, but alters the order of the _ownedTokens array._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | address representing the previous owner of the given token ID |
| tokenId | uint256 | uint256 ID of the token to be removed from the tokens list of the given address |

### _removeTokenFromAllTokensEnumeration

```solidity
function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private
```

_Private function to remove a token from this extension's token tracking data structures.
This has O(1) time complexity, but alters the order of the _allTokens array._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | uint256 ID of the token to be removed from the tokens list |

## ERC721Burnable

_ERC721 Token that can be irreversibly burned (destroyed)._

### burn

```solidity
function burn(uint256 tokenId) public virtual
```

_Burns `tokenId`. See {ERC721-_burn}.

Requirements:

- The caller must own `tokenId` or be an approved operator._

## Pausable

_Contract module which allows children to implement an emergency stop
mechanism that can be triggered by an authorized account.

This module is used through inheritance. It will make available the
modifiers `whenNotPaused` and `whenPaused`, which can be applied to
the functions of your contract. Note that they will not be pausable by
simply including this module, only once the modifiers are put in place._

### Paused

```solidity
event Paused(address account)
```

_Emitted when the pause is triggered by `account`._

### Unpaused

```solidity
event Unpaused(address account)
```

_Emitted when the pause is lifted by `account`._

### _paused

```solidity
bool _paused
```

### constructor

```solidity
constructor() internal
```

_Initializes the contract in unpaused state._

### paused

```solidity
function paused() public view virtual returns (bool)
```

_Returns true if the contract is paused, and false otherwise._

### whenNotPaused

```solidity
modifier whenNotPaused()
```

_Modifier to make a function callable only when the contract is not paused.

Requirements:

- The contract must not be paused._

### whenPaused

```solidity
modifier whenPaused()
```

_Modifier to make a function callable only when the contract is paused.

Requirements:

- The contract must be paused._

### _pause

```solidity
function _pause() internal virtual
```

_Triggers stopped state.

Requirements:

- The contract must not be paused._

### _unpause

```solidity
function _unpause() internal virtual
```

_Returns to normal state.

Requirements:

- The contract must be paused._

## ERC721Pausable

_ERC721 token with pausable token transfers, minting and burning.

Useful for scenarios such as preventing trades until the end of an evaluation
period, or having an emergency switch for freezing all token transfers in the
event of a large bug._

### _beforeTokenTransfer

```solidity
function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual
```

_See {ERC721-_beforeTokenTransfer}.

Requirements:

- the contract must not be paused._

## ERC721URIStorage

_ERC721 token with storage based token uri management._

### _tokenURIs

```solidity
mapping(uint256 => string) _tokenURIs
```

### tokenURI

```solidity
function tokenURI(uint256 tokenId) public view virtual returns (string)
```

_See {IERC721Metadata-tokenURI}._

### _setTokenURI

```solidity
function _setTokenURI(uint256 tokenId, string _tokenURI) internal virtual
```

_Sets `_tokenURI` as the tokenURI of `tokenId`.

Requirements:

- `tokenId` must exist._

### _burn

```solidity
function _burn(uint256 tokenId) internal virtual
```

_Destroys `tokenId`.
The approval is cleared when the token is burned.

Requirements:

- `tokenId` must exist.

Emits a {Transfer} event._

## IAccessControl

_External interface of AccessControl declared to support ERC165 detection._

### hasRole

```solidity
function hasRole(bytes32 role, address account) external view returns (bool)
```

### getRoleAdmin

```solidity
function getRoleAdmin(bytes32 role) external view returns (bytes32)
```

### grantRole

```solidity
function grantRole(bytes32 role, address account) external
```

### revokeRole

```solidity
function revokeRole(bytes32 role, address account) external
```

### renounceRole

```solidity
function renounceRole(bytes32 role, address account) external
```

## AccessControl

_Contract module that allows children to implement role-based access
control mechanisms. This is a lightweight version that doesn't allow enumerating role
members except through off-chain means by accessing the contract event logs. Some
applications may benefit from on-chain enumerability, for those cases see
{AccessControlEnumerable}.

Roles are referred to by their `bytes32` identifier. These should be exposed
in the external API and be unique. The best way to achieve this is by
using `public constant` hash digests:

```
bytes32 public constant MY_ROLE = keccak256("MY_ROLE");
```

Roles can be used to represent a set of permissions. To restrict access to a
function call, use {hasRole}:

```
function foo() public {
    require(hasRole(MY_ROLE, msg.sender));
    ...
}
```

Roles can be granted and revoked dynamically via the {grantRole} and
{revokeRole} functions. Each role has an associated admin role, and only
accounts that have a role's admin role can call {grantRole} and {revokeRole}.

By default, the admin role for all roles is `DEFAULT_ADMIN_ROLE`, which means
that only accounts with this role will be able to grant or revoke other
roles. More complex role relationships can be created by using
{_setRoleAdmin}.

WARNING: The `DEFAULT_ADMIN_ROLE` is also its own admin: it has permission to
grant and revoke this role. Extra precautions should be taken to secure
accounts that have been granted it._

### RoleData

```solidity
struct RoleData {
  mapping(address => bool) members;
  bytes32 adminRole;
}
```

### _roles

```solidity
mapping(bytes32 => struct AccessControl.RoleData) _roles
```

### DEFAULT_ADMIN_ROLE

```solidity
bytes32 DEFAULT_ADMIN_ROLE
```

### RoleAdminChanged

```solidity
event RoleAdminChanged(bytes32 role, bytes32 previousAdminRole, bytes32 newAdminRole)
```

_Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`

`DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
{RoleAdminChanged} not being emitted signaling this.

_Available since v3.1.__

### RoleGranted

```solidity
event RoleGranted(bytes32 role, address account, address sender)
```

_Emitted when `account` is granted `role`.

`sender` is the account that originated the contract call, an admin role
bearer except when using {_setupRole}._

### RoleRevoked

```solidity
event RoleRevoked(bytes32 role, address account, address sender)
```

_Emitted when `account` is revoked `role`.

`sender` is the account that originated the contract call:
  - if using `revokeRole`, it is the admin role bearer
  - if using `renounceRole`, it is the role bearer (i.e. `account`)_

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}._

### hasRole

```solidity
function hasRole(bytes32 role, address account) public view returns (bool)
```

_Returns `true` if `account` has been granted `role`._

### getRoleAdmin

```solidity
function getRoleAdmin(bytes32 role) public view returns (bytes32)
```

_Returns the admin role that controls `role`. See {grantRole} and
{revokeRole}.

To change a role's admin, use {_setRoleAdmin}._

### grantRole

```solidity
function grantRole(bytes32 role, address account) public virtual
```

_Grants `role` to `account`.

If `account` had not been already granted `role`, emits a {RoleGranted}
event.

Requirements:

- the caller must have ``role``'s admin role._

### revokeRole

```solidity
function revokeRole(bytes32 role, address account) public virtual
```

_Revokes `role` from `account`.

If `account` had been granted `role`, emits a {RoleRevoked} event.

Requirements:

- the caller must have ``role``'s admin role._

### renounceRole

```solidity
function renounceRole(bytes32 role, address account) public virtual
```

_Revokes `role` from the calling account.

Roles are often managed via {grantRole} and {revokeRole}: this function's
purpose is to provide a mechanism for accounts to lose their privileges
if they are compromised (such as when a trusted device is misplaced).

If the calling account had been granted `role`, emits a {RoleRevoked}
event.

Requirements:

- the caller must be `account`._

### _setupRole

```solidity
function _setupRole(bytes32 role, address account) internal virtual
```

_Grants `role` to `account`.

If `account` had not been already granted `role`, emits a {RoleGranted}
event. Note that unlike {grantRole}, this function doesn't perform any
checks on the calling account.

[WARNING]
====
This function should only be called from the constructor when setting
up the initial roles for the system.

Using this function in any other way is effectively circumventing the admin
system imposed by {AccessControl}.
====_

### _setRoleAdmin

```solidity
function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal virtual
```

_Sets `adminRole` as ``role``'s admin role.

Emits a {RoleAdminChanged} event._

### _grantRole

```solidity
function _grantRole(bytes32 role, address account) private
```

### _revokeRole

```solidity
function _revokeRole(bytes32 role, address account) private
```

## EnumerableSet

_Library for managing
https://en.wikipedia.org/wiki/Set_(abstract_data_type)[sets] of primitive
types.

Sets have the following properties:

- Elements are added, removed, and checked for existence in constant time
(O(1)).
- Elements are enumerated in O(n). No guarantees are made on the ordering.

```
contract Example {
    // Add the library methods
    using EnumerableSet for EnumerableSet.AddressSet;

    // Declare a set state variable
    EnumerableSet.AddressSet private mySet;
}
```

As of v3.3.0, sets of type `bytes32` (`Bytes32Set`), `address` (`AddressSet`)
and `uint256` (`UintSet`) are supported._

### Set

```solidity
struct Set {
  bytes32[] _values;
  mapping(bytes32 => uint256) _indexes;
}
```

### _add

```solidity
function _add(struct EnumerableSet.Set set, bytes32 value) private returns (bool)
```

_Add a value to a set. O(1).

Returns true if the value was added to the set, that is if it was not
already present._

### _remove

```solidity
function _remove(struct EnumerableSet.Set set, bytes32 value) private returns (bool)
```

_Removes a value from a set. O(1).

Returns true if the value was removed from the set, that is if it was
present._

### _contains

```solidity
function _contains(struct EnumerableSet.Set set, bytes32 value) private view returns (bool)
```

_Returns true if the value is in the set. O(1)._

### _length

```solidity
function _length(struct EnumerableSet.Set set) private view returns (uint256)
```

_Returns the number of values on the set. O(1)._

### _at

```solidity
function _at(struct EnumerableSet.Set set, uint256 index) private view returns (bytes32)
```

_Returns the value stored at position `index` in the set. O(1).

Note that there are no guarantees on the ordering of values inside the
array, and it may change when more values are added or removed.

Requirements:

- `index` must be strictly less than {length}._

### Bytes32Set

```solidity
struct Bytes32Set {
  struct EnumerableSet.Set _inner;
}
```

### add

```solidity
function add(struct EnumerableSet.Bytes32Set set, bytes32 value) internal returns (bool)
```

_Add a value to a set. O(1).

Returns true if the value was added to the set, that is if it was not
already present._

### remove

```solidity
function remove(struct EnumerableSet.Bytes32Set set, bytes32 value) internal returns (bool)
```

_Removes a value from a set. O(1).

Returns true if the value was removed from the set, that is if it was
present._

### contains

```solidity
function contains(struct EnumerableSet.Bytes32Set set, bytes32 value) internal view returns (bool)
```

_Returns true if the value is in the set. O(1)._

### length

```solidity
function length(struct EnumerableSet.Bytes32Set set) internal view returns (uint256)
```

_Returns the number of values in the set. O(1)._

### at

```solidity
function at(struct EnumerableSet.Bytes32Set set, uint256 index) internal view returns (bytes32)
```

_Returns the value stored at position `index` in the set. O(1).

Note that there are no guarantees on the ordering of values inside the
array, and it may change when more values are added or removed.

Requirements:

- `index` must be strictly less than {length}._

### AddressSet

```solidity
struct AddressSet {
  struct EnumerableSet.Set _inner;
}
```

### add

```solidity
function add(struct EnumerableSet.AddressSet set, address value) internal returns (bool)
```

_Add a value to a set. O(1).

Returns true if the value was added to the set, that is if it was not
already present._

### remove

```solidity
function remove(struct EnumerableSet.AddressSet set, address value) internal returns (bool)
```

_Removes a value from a set. O(1).

Returns true if the value was removed from the set, that is if it was
present._

### contains

```solidity
function contains(struct EnumerableSet.AddressSet set, address value) internal view returns (bool)
```

_Returns true if the value is in the set. O(1)._

### length

```solidity
function length(struct EnumerableSet.AddressSet set) internal view returns (uint256)
```

_Returns the number of values in the set. O(1)._

### at

```solidity
function at(struct EnumerableSet.AddressSet set, uint256 index) internal view returns (address)
```

_Returns the value stored at position `index` in the set. O(1).

Note that there are no guarantees on the ordering of values inside the
array, and it may change when more values are added or removed.

Requirements:

- `index` must be strictly less than {length}._

### UintSet

```solidity
struct UintSet {
  struct EnumerableSet.Set _inner;
}
```

### add

```solidity
function add(struct EnumerableSet.UintSet set, uint256 value) internal returns (bool)
```

_Add a value to a set. O(1).

Returns true if the value was added to the set, that is if it was not
already present._

### remove

```solidity
function remove(struct EnumerableSet.UintSet set, uint256 value) internal returns (bool)
```

_Removes a value from a set. O(1).

Returns true if the value was removed from the set, that is if it was
present._

### contains

```solidity
function contains(struct EnumerableSet.UintSet set, uint256 value) internal view returns (bool)
```

_Returns true if the value is in the set. O(1)._

### length

```solidity
function length(struct EnumerableSet.UintSet set) internal view returns (uint256)
```

_Returns the number of values on the set. O(1)._

### at

```solidity
function at(struct EnumerableSet.UintSet set, uint256 index) internal view returns (uint256)
```

_Returns the value stored at position `index` in the set. O(1).

Note that there are no guarantees on the ordering of values inside the
array, and it may change when more values are added or removed.

Requirements:

- `index` must be strictly less than {length}._

## IAccessControlEnumerable

_External interface of AccessControlEnumerable declared to support ERC165 detection._

### getRoleMember

```solidity
function getRoleMember(bytes32 role, uint256 index) external view returns (address)
```

### getRoleMemberCount

```solidity
function getRoleMemberCount(bytes32 role) external view returns (uint256)
```

## AccessControlEnumerable

_Extension of {AccessControl} that allows enumerating the members of each role._

### _roleMembers

```solidity
mapping(bytes32 => struct EnumerableSet.AddressSet) _roleMembers
```

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}._

### getRoleMember

```solidity
function getRoleMember(bytes32 role, uint256 index) public view returns (address)
```

_Returns one of the accounts that have `role`. `index` must be a
value between 0 and {getRoleMemberCount}, non-inclusive.

Role bearers are not sorted in any particular way, and their ordering may
change at any point.

WARNING: When using {getRoleMember} and {getRoleMemberCount}, make sure
you perform all queries on the same block. See the following
https://forum.openzeppelin.com/t/iterating-over-elements-on-enumerableset-in-openzeppelin-contracts/2296[forum post]
for more information._

### getRoleMemberCount

```solidity
function getRoleMemberCount(bytes32 role) public view returns (uint256)
```

_Returns the number of accounts that have `role`. Can be used
together with {getRoleMember} to enumerate all bearers of a role._

### grantRole

```solidity
function grantRole(bytes32 role, address account) public virtual
```

_Overload {grantRole} to track enumerable memberships_

### revokeRole

```solidity
function revokeRole(bytes32 role, address account) public virtual
```

_Overload {revokeRole} to track enumerable memberships_

### renounceRole

```solidity
function renounceRole(bytes32 role, address account) public virtual
```

_Overload {renounceRole} to track enumerable memberships_

### _setupRole

```solidity
function _setupRole(bytes32 role, address account) internal virtual
```

_Overload {_setupRole} to track enumerable memberships_

## Counters

_Provides counters that can only be incremented or decremented by one. This can be used e.g. to track the number
of elements in a mapping, issuing ERC721 ids, or counting request ids.

Include with `using Counters for Counters.Counter;`_

### Counter

```solidity
struct Counter {
  uint256 _value;
}
```

### current

```solidity
function current(struct Counters.Counter counter) internal view returns (uint256)
```

### increment

```solidity
function increment(struct Counters.Counter counter) internal
```

### decrement

```solidity
function decrement(struct Counters.Counter counter) internal
```

## AvaxApes

_{ERC721} token, including:

 - ability for holders to burn (destroy) their tokens
 - a minter role that allows for token minting (creation)
 - token ID and URI autogeneration

This contract uses {AccessControl} to lock permissioned functions using the
different roles - head to its documentation for details.

The account that deploys the contract will be granted the minter and pauser
roles, as well as the default admin role, which will let it grant both minter
and pauser roles to other accounts._

### _tokenIdTracker

```solidity
struct Counters.Counter _tokenIdTracker
```

### _baseTokenURI

```solidity
string _baseTokenURI
```

### _price

```solidity
uint256 _price
```

### _max

```solidity
uint256 _max
```

### _admin

```solidity
address _admin
```

### _admin2

```solidity
address _admin2
```

### reflectionBalance

```solidity
uint256 reflectionBalance
```

### totalDividend

```solidity
uint256 totalDividend
```

### lastDividendAt

```solidity
mapping(uint256 => uint256) lastDividendAt
```

### minter

```solidity
mapping(uint256 => address) minter
```

### constructor

```solidity
constructor(string name, string symbol, string baseTokenURI, uint256 mintPrice, uint256 max, address admin, address admin2) public
```

### _baseURI

```solidity
function _baseURI() internal view virtual returns (string)
```

_Base URI for computing {tokenURI}. Empty by default, can be overriden
in child contracts._

### setBaseURI

```solidity
function setBaseURI(string baseURI) external
```

### setTokenURI

```solidity
function setTokenURI(uint256 tokenId, string _tokenURI) external
```

### setPrice

```solidity
function setPrice(uint256 mintPrice) external
```

### price

```solidity
function price() public view returns (uint256)
```

### mint

```solidity
function mint(uint256 amount) public payable
```

### tokenMinter

```solidity
function tokenMinter(uint256 tokenId) public view returns (address)
```

### _burn

```solidity
function _burn(uint256 tokenId) internal virtual
```

### tokenURI

```solidity
function tokenURI(uint256 tokenId) public view returns (string)
```

### _beforeTokenTransfer

```solidity
function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual
```

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}._

### currentRate

```solidity
function currentRate() public view returns (uint256)
```

### claimRewards

```solidity
function claimRewards() public
```

### getReflectionBalances

```solidity
function getReflectionBalances() public view returns (uint256)
```

### claimReward

```solidity
function claimReward(uint256 tokenId) public
```

### getReflectionBalance

```solidity
function getReflectionBalance(uint256 tokenId) public view returns (uint256)
```

### splitBalance

```solidity
function splitBalance(uint256 amount) private
```

### reflectDividend

```solidity
function reflectDividend(uint256 amount) private
```

### reflectToOwners

```solidity
function reflectToOwners() public payable
```

