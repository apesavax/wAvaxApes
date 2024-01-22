// SPDX-License-Identifier: MIT
// wAvax Apes by xrpant

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import "./erc721a/contracts/extensions/ERC721AQueryable.sol";

pragma solidity ^0.8.20;

/// @notice Error caused by trying to mint more than 10k
error MaxMinted();

/// @notice Error caused by failed withdrawal of AVAX
error TransferFailed();

/// @notice Error caused by trying to send an invalid NFT to contract
error InvalidNFT();

/// @notice Error caused by trying to wrap an Ape while the contract is paused
error ContractPaused();

/// @notice Error caused by trying to set an invalid royalty bps
error InvalidBps();

/// @notice Error caused by trying to set the royalty address to address(0)
error ZeroAddress();

contract wAvaxApes is ERC721AQueryable, IERC721Receiver, IERC2981, ReentrancyGuard, Ownable {
    using SafeERC20 for IERC20;
    using Strings for uint256;

    string public baseURI = "ipfs://bafybeiffbocd3ejxre56m6ks4qt6ezjl2dhr37j6xojmg5owdd2vsvdqnm/";

    uint256 public royaltyBps = 500;

    address public royaltyAddress = 0x5BcD0455E8b83A2d3Ad3E1e8Ca635779D7d5a253; 

    bool public paused = false;

    IERC721Enumerable public constant OG = IERC721Enumerable(0x6d5087B3082f73D42a32D85e38BC95dcceDe39Bb);

    event ApesWrapped(uint256[] tokenIds);
    event ApesUnwrapped(uint256[] tokenIds);
    event SetBaseURI(string uri);
    event SetRoyaltyAddress(address royaltyAddress);
    event SetRoyaltyBps(uint256 bps);
    event SetPaused(bool state);
    event ERC20Withdrawn(address tokens, uint256 amount);
    event AVAXWithdrawn(uint256 amount);

    receive() external payable {}

    /// @dev _mintERC2309 was tested and provides significant gas savings on deploy, but caused issues with snowtrace
    /// recognizing the minted tokens so it was decided to just use _mint.
    constructor() ERC721A("wAvax Apes", "WAVAXAPE") {
        _mint(address(this), 5_000);
    }

    /// @notice Used to wrap OG Apes. Users deposit OG NFT and recieve an ERC721A copy.
    /// @dev _tokenApprovals in ERC721A was modified to be internal rather than private so that it could be 
    /// used in this way. Since ERC721A has no internal _transfer function there was no way to have the contract send 
    /// an nft to caller without this modification because of lacking approvals. Approvals are cleared on transfer.
    function wrap(uint256[] calldata _tokenIds) public nonReentrant {
        if (paused) revert ContractPaused();

        uint256 length = _tokenIds.length;
        for(uint256 i = 0; i < length; i++) {
            OG.transferFrom(msg.sender, address(this), _tokenIds[i]);
            _tokenApprovals[_tokenIds[i]].value = msg.sender;
            transferFrom(address(this), msg.sender, _tokenIds[i]);
        }

        emit ApesWrapped(_tokenIds);
    }

    /// @notice Used to unwrap OG Apes. Users deposit their ERC721A copy and receive the original Ape back.
    function unwrap(uint256[] calldata _tokenIds) public nonReentrant {
        uint256 length = _tokenIds.length;
        for(uint256 i = 0; i < length; i++) {
            transferFrom(msg.sender, address(this), _tokenIds[i]);
            OG.transferFrom(address(this), msg.sender, _tokenIds[i]);
        }

        emit ApesUnwrapped(_tokenIds);
    }

    /// @notice View function that returns an array of OG Ape token ids held by an address.
    /// @dev While the OG Apes are ERC721Enumerable, there is no view function to get an array of token ids. 
    /// This function prevents having the app front-end from having to call tokenOfOwnerByIndex many times to get holdings.
    function getWalletOfOwnerOG(address _holder) external view returns(uint256[] memory) {
        uint256 count = OG.balanceOf(_holder);
		uint256[] memory tokens = new uint256[](count);

        for(uint256 i = 0; i < count; i++) {
            tokens[i] = OG.tokenOfOwnerByIndex(_holder, i);
        }

		return tokens;
    }

    /// @notice View function that returns the token URI.
    function tokenURI(uint256 tokenId) public view virtual override (ERC721A, IERC721A) returns (string memory) {
        if (!_exists(tokenId)) revert URIQueryForNonexistentToken();
        
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }

    /// @notice EIP2981 RoyaltyInfo
    function royaltyInfo(uint256, uint256 salePrice)
        external
        view
        override
        returns (address, uint256) {
        return (royaltyAddress, salePrice * royaltyBps / 10000);
    }

    /// @notice Used to pause deposits. Withdrawals are unaffected.
    function flipPaused() public onlyOwner {
        paused = !paused;
        emit SetPaused(paused);
    }

    /// @notice Used to set royalty percentage
    function setRoyaltyBps(uint256 _newBps) public onlyOwner {
        if (_newBps > 1000) revert InvalidBps();
        royaltyBps = _newBps;
        emit SetRoyaltyBps(_newBps);
    }

    /// @notice Used to set new royalty address
    function setRoyaltyAddress(address _newAddress) public onlyOwner {
        if (_newAddress == address(0)) revert ZeroAddress();
        royaltyAddress = _newAddress;
        emit SetRoyaltyAddress(_newAddress);
    }

    /// @notice Used to update base URI
    function updateBaseURI(string calldata _newURI) public onlyOwner {
        baseURI = _newURI;
        emit SetBaseURI(_newURI);
    }

    /// @notice Used to mint remaining tokens to the contract
    /// @dev The first 5k are minted in the constructor, which is the max allowed due to gas constraints.
    /// Once this function is called once, it cannot be called again, capping the supply.
    function mintRemainder() public onlyOwner {
        if (totalSupply() >= 10_000) revert MaxMinted();
        _mint(address(this), 5_000);
    }

    /// @notice Used to withdraw ERC20 tokens that become locked in the contract.
    function emergencyWithdrawERC20(address _contract) public onlyOwner {
        IERC20 _token = IERC20(_contract);
        uint256 _balance = _token.balanceOf(address(this));

        _token.safeTransfer(msg.sender, _balance);
        emit ERC20Withdrawn(_contract, _balance);
    }

    /// @notice Used to withdraw AVAX that gets sent to the contract. 
    /// @dev AVAX will be sent to the contract via the OG Apes internal marketplace when Apes are unwrapped due 
    /// to the marketplace royalty share mechanism.
    function emergencyWithdraw() public onlyOwner {
        uint256 _balance = address(this).balance;
		(bool success, ) = payable(owner()).call{ value: _balance }("");
        
		if (!success) revert TransferFailed();
        emit AVAXWithdrawn(_balance);
	}

    /// @notice Support for interfaces
    function supportsInterface(bytes4 interfaceId) public view override (ERC721A, IERC721A, IERC165) returns(bool) {
        return interfaceId == type(IERC2981).interfaceId || 
                              ERC721A.supportsInterface(interfaceId) ||
                              super.supportsInterface(interfaceId);
    }

    /// @notice ERC721Receiver implementation
    function onERC721Received(address, address, uint256, bytes calldata) external view override returns (bytes4) {
        if (msg.sender != address(OG) && msg.sender != address(this)) revert InvalidNFT();
        return IERC721Receiver.onERC721Received.selector;
    }

}