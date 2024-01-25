//SPDX-License-Identifier: None
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AvaxApesMarketV2 is AccessControlEnumerable, Pausable {
    event Sale(address indexed seller, address indexed buyer, uint256 indexed tokenId, uint256 price);
    event ListingCreated(address indexed seller, address indexed buyer, uint256 indexed tokenId, uint256 price);
    event ListingCancelled(uint256 indexed tokenId);
    event OfferCreated(address indexed creator, uint256 tokenId, uint256 pricePerItem, uint256 deadline);
    event OfferCanceled(address indexed creator, uint256 tokenId);

    AvaxApesInterface masterContract;
    WrapperInterface wrapper;

    address public wrapperAddress;

    uint256 private _devRoyalty;
    uint256 private _minterRoyalty;
    uint256 private _reflectionRoyalty;

    address private _admin;

    mapping(uint256 => Listing) public listings;
    mapping(uint256 => mapping(address => Offer)) public offers;

    struct Listing {
        address seller;
        address buyer;
        uint256 tokenId;
        uint256 price;
        bool exists;
    }

    struct Offer {
        uint256 quantity;
        uint256 pricePerItem;
        uint256 deadline;
    }

    modifier offerExists(uint256 _tokenId, address _creator) {
        Offer memory offer = offers[_tokenId][_creator];
        require(offer.quantity > 0 && offer.deadline > _getNow(), "AvaxApesMarket: offer does not exist or expired");
        _;
    }

    modifier offerNotExists(uint256 _tokenId, address _creator) {
        Offer memory offer = offers[_tokenId][_creator];
        require(offer.quantity == 0 || offer.deadline <= _getNow(), "AvaxApesMarket: offer already created");
        _;
    }

    constructor(
        address AvaxApesAddress,
        address WrapperAddress,
        uint devRoyalty,
        uint minterRoyalty,
        uint reflectionRoyalty,
        address admin
    ) {
        masterContract = AvaxApesInterface(AvaxApesAddress);
        wrapper = WrapperInterface(WrapperAddress);
        wrapperAddress = WrapperAddress;
        _devRoyalty = devRoyalty;
        _minterRoyalty = minterRoyalty;
        _reflectionRoyalty = reflectionRoyalty;
        _admin = admin;
        _setupRole(DEFAULT_ADMIN_ROLE, admin);
    }

    receive() external payable {}

    modifier isTokenOwner(uint256 tokenId) {
        address caller = masterContract.ownerOf(tokenId);
        require(caller == msg.sender, "AvaxApesMarket: caller is not the owner of the token");
        _;
    }

    function createPrivateListing(
        uint256 tokenId,
        uint256 price,
        address buyer
    ) external whenNotPaused isTokenOwner(tokenId) {
        require(
            masterContract.getApproved(tokenId) == address(this),
            "AvaxApesMarket: market must be approved to transfer avax ape"
        );
        listings[tokenId] = Listing(msg.sender, buyer, tokenId, price, true);
        emit ListingCreated(msg.sender, buyer, tokenId, price);
    }

    function createListing(uint256 tokenId, uint256 price) external whenNotPaused isTokenOwner(tokenId) {
        require(
            masterContract.getApproved(tokenId) == address(this),
            "AvaxApesMarket: market must be approved to transfer avax ape"
        );
        listings[tokenId] = Listing(msg.sender, address(0), tokenId, price, true);
        emit ListingCreated(msg.sender, address(0), tokenId, price);
    }

    function getListing(uint256 tokenId) external view returns (address, address, uint256, uint256, bool) {
        Listing memory listing = listings[tokenId];
        return (listing.seller, listing.buyer, listing.tokenId, listing.price, listing.exists);
    }

    function cancelListing(uint256 tokenId) external whenNotPaused isTokenOwner(tokenId) {
        Listing memory trade = listings[tokenId];
        require(trade.exists == true, "AvaxApesMarket: avax ape not for sale");
        listings[tokenId] = Listing(address(0), address(0), 0, 0, false);
        emit ListingCancelled(tokenId);
    }

    function buy(uint256 tokenId) external payable whenNotPaused {
        Listing memory trade = listings[tokenId];
        require(trade.exists == true, "AvaxApesMarket: avax ape not for sale");
        require(msg.value == trade.price, "AvaxApesMarket: must send correct amount to buy");
        require(
            masterContract.ownerOf(tokenId) == trade.seller,
            "AvaxApesMarket: seller must equal current avax ape owner"
        );
        if (trade.buyer != address(0)) {
            require(trade.buyer == msg.sender, "AvaxApesMarket: listing is not available to the caller");
        }

        address minter = masterContract.tokenMinter(tokenId);

        payable(trade.seller).transfer(
            ((msg.value * (100 - (_devRoyalty + _minterRoyalty + _reflectionRoyalty))) / 100)
        );
        payable(_admin).transfer((msg.value * _devRoyalty) / 100);
        payable(minter).transfer((msg.value * _minterRoyalty) / 100);
        masterContract.reflectToOwners{value: (msg.value * _reflectionRoyalty) / 100}();

        masterContract.transferFrom(trade.seller, msg.sender, tokenId);
        listings[tokenId] = Listing(address(0), address(0), 0, 0, false);

        emit Sale(trade.seller, msg.sender, tokenId, msg.value);
    }

    function setMinterRoyalty(uint256 royalty) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "AvaxApes: must have admin role to set royalty");
        _minterRoyalty = royalty;
    }

    function setDevRoyalty(uint256 royalty) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "AvaxApes: must have admin role to set royalty");
        _devRoyalty = royalty;
    }

    function setReflectionRoyalty(uint256 royalty) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "AvaxApes: must have admin role to set royalty");
        _reflectionRoyalty = royalty;
    }

    function setMasterAddress(address masterAddress) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "AvaxApes: must have admin role to set master address");
        masterContract = AvaxApesInterface(masterAddress);
    }

    function pause() external {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "AvaxApes: must have admin role to pause");
        _pause();
    }

    function unpause() external {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "AvaxApes: must have admin role to unpause");
        _unpause();
    }

    function _getNow() internal view virtual returns (uint256) {
        return block.timestamp;
    }

    function createOffer(
        uint256 _tokenId,
        uint256 _pricePerItem,
        uint256 _deadline
    ) external offerNotExists(_tokenId, _msgSender()) whenNotPaused {
        require(_deadline > _getNow(), "invalid expiration");

        offers[_tokenId][_msgSender()] = Offer(1, _pricePerItem, _deadline);

        emit OfferCreated(_msgSender(), _tokenId, _pricePerItem, _deadline);
    }

    function cancelOffer(uint256 _tokenId) external offerExists(_tokenId, _msgSender()) whenNotPaused {
        delete (offers[_tokenId][_msgSender()]);
        emit OfferCanceled(_msgSender(), _tokenId);
    }

    /// @param _creator Offer creator address
    function acceptOffer(
        uint256 _tokenId,
        address _creator
    ) external offerExists(_tokenId, _creator) isTokenOwner(_tokenId) whenNotPaused {
        Offer memory offer = offers[_tokenId][_creator];

        uint256 price = offer.pricePerItem;

        //unwrap avax
        IERC20(wrapperAddress).transferFrom(_creator, address(this), price);
        wrapper.withdraw(price);

        address minter = masterContract.tokenMinter(_tokenId);

        payable(msg.sender).transfer(((price * (100 - (_devRoyalty + _minterRoyalty + _reflectionRoyalty))) / 100));
        payable(_admin).transfer((price * _devRoyalty) / 100);
        payable(minter).transfer((price * _minterRoyalty) / 100);
        masterContract.reflectToOwners{value: (price * _reflectionRoyalty) / 100}();
        masterContract.transferFrom(msg.sender, _creator, _tokenId);

        listings[_tokenId] = Listing(address(0), address(0), 0, 0, false);
        delete (offers[_tokenId][_creator]);

        emit Sale(msg.sender, _creator, _tokenId, price);
        emit OfferCanceled(_creator, _tokenId);
    }
}

abstract contract AvaxApesInterface {
    function ownerOf(uint256 id) public virtual returns (address);

    function transferFrom(address from, address to, uint256 id) public virtual;

    function getApproved(uint256 tokenId) public view virtual returns (address);

    function tokenMinter(uint256 tokenId) public view virtual returns (address);

    function reflectToOwners() public payable virtual;
}

abstract contract WrapperInterface {
    function withdraw(uint wad) public virtual;
}
