pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

import { PortfolioDataStorages } from "./Portfolio-data/PortfolioDataStorages.sol";
import { PortfolioNFT } from "./PortfolioNFT.sol";


/**
 * @notice - This is the storage contract for Portfolio's
 */
contract PortfolioData is PortfolioDataStorages {

    address[] public portfolioAddresses;

    constructor() public {}



    
    /**
     * @notice - Create a new portfolioNFT 
     */
    function createNewPortfolioNFT(
        address owner,   
        string memory nameNFT, 
        string memory portfolioNFTSymbol,
        string memory description,
        string memory creatorName ,
        string memory twitterLink ,
        string memory redditLink ,
        string memory tradingviewLink ) public returns (bool) {
        address owner = msg.sender;  
        /// [Note]: Initial owner of photoNFT is msg.sender
        PortfolioNFT portfolioNFT = new PortfolioNFT(owner, nftName, nftSymbol, tokenURI, photoPrice, typeOfSale,redevance,seller);
        portfolioNFTAddresses.push(address(portfolioNFT));
        /// Save metadata of a photoNFT created
        saveMetadataOfPortfolioNFTNFT(photoAddresses, photoNFT,  nftSymbol, msg.sender, photoPrice, ipfsHashOfPhoto, typeOfSale,redevance, seller);


        emit PortfolioNFTNFTCreated(msg.sender, photoNFT, nftName, nftSymbol, photoPrice, ipfsHashOfPhoto, typeOfSale,redevance,seller);
    }


    /**
     * @notice - Save metadata of a Portfolio
     */
    function saveMetadataOfPortfolio(
        address[] memory _portfolioAddresses, 
        PortfolioNFT _portfolioNFT, 
        string memory _Name, 
        string memory _Symbol, 
        address _ownerAddress, 
        string memory _description,
        string memory _creatorName,
        string memory _twitterLink,
        string memory _redditLink,
        string memory _tradingviewLink
    ) public returns (bool) {
        /// Save metadata of a Portfolio 
        Portfolio memory portfolio = Portfolio({
        portfolioNFT: _portfolioNFT,
        owner :_ownerAddress, 
        name: _Name, 
        symbol: _Symbol,
        description: _description,
        creatorName: _creatorName ,
        twitterLink: _twitterLink ,
        redditLink: _redditLink ,
        tradingViewLink: _tradingviewLink
        });
        portfolios.push(portfolio);

        /// Update PortfolioAddresses
        portfolioAddresses = _portfolioAddresses;     
    }





    ///-----------------
    /// Getter methods
    ///-----------------
    function getPortfolio(uint index) public view returns (Portfolio memory _portfolio) {
        Portfolio memory portfolio = portfolios[index];
        return portfolio;
    }

    function getPortfolioIndex(Portfolio portfolio) public view returns (uint _portfolioIndex) {
        address PORTFOLIO = address(portfolio);

        /// Identify member's index
        uint portfolioIndex;
        for (uint i=0; i < portfolioAddresses.length; i++) {
            if (portfolioAddresses[i] == PORTFOLIO) {
                portfolioIndex = i;
            }
        }

        return portfolioIndex;   
    }

    function getPortfolioAddress(Portfolio portfolio) public view returns (Portfolio memory _portfolio) {
        address PORTFOLIO = address(portfolio);

        /// Identify member's index
        uint portfolioIndex;
        for (uint i=0; i < portfolioAddresses.length; i++) {
            if (portfolioAddresses[i] == PORTFOLIO) {
                portfolioIndex = i;
            }
        }

        Portfolio memory portfolio = portfolios[portfolioIndex];
        return portfolio;
    }

    function getAllPortfolios() public view returns (Portfolio[] memory _portfolios) {
        return portfolios;
    }

}
