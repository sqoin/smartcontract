pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

import { PortfolioDataStorages } from "./PortfolioData/PortfolioDataStorages.sol";
import { PortfolioNFT } from "./PortfolioNFT.sol";


/**
 * @notice - This is the storage contract for Portfolio's
 */
contract PortfolioData is PortfolioDataStorages {

    address[] public portfolioAddresses;

    constructor() public {}



    


    /**
     * @notice - Save metadata of a Portfolio
     */
    function saveMetadataOfPortfolioNFT(

        address _portfolioNFT, 
        address _ownerAddress,
        string memory _Name, 
        string memory _Symbol, 
        string memory _description,
        string[] memory _assetsNames,
        uint256[] memory _assetsValues
    ) public returns (bool) {
        /// Save metadata of a Portfolio 
 

        Portfolio memory portfolio = Portfolio({
        portfolioNFT: _portfolioNFT,
        owner :_ownerAddress, 
        nameNFT: _Name, 
        symbolNFT: _Symbol,
        description: _description,
        assetsNames: _assetsNames,
        assetsValues: _assetsValues
        });
        portfolios.push(portfolio);

        /// Update PortfolioAddresses
          portfolioAddresses.push(_portfolioNFT);
   
    }





    ///-----------------
    /// Getter methods
    ///-----------------
    function getPortfolio(uint index) public view returns (Portfolio memory _portfolio) {
        Portfolio memory portfolio = portfolios[index];
        return portfolio;
    }

    function getPortfolioIndex(address portfolio) public view returns (uint _portfolioIndex) {
        //address PORTFOLIO = address(portfolio);

        /// Identify member's index
        uint portfolioIndex;
        for (uint i=0; i < portfolioAddresses.length; i++) {
            if (portfolioAddresses[i] == portfolio) {
                portfolioIndex = i;
            }
        }

        return portfolioIndex;   
    }

    function getPortfolioByAddress(address portfolio) public view returns (Portfolio memory _portfolio) {
        //address PORTFOLIO = address(portfolio);

        /// Identify member's index
        uint portfolioIndex;
        for (uint i=0; i < portfolioAddresses.length; i++) {
            if (portfolioAddresses[i] == portfolio) {
                portfolioIndex = i;
            }
        }

        Portfolio memory portfolioX = portfolios[portfolioIndex];
        return portfolioX;
    }

    function getAllPortfolios() public view returns (Portfolio[] memory _portfolios) {
        return portfolios;
    }

}
