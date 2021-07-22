pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

import { PortfolioDataStorages  } from "./PortfolioData/PortfolioDataStorages.sol";
import { PortfolioDataObjects } from "./PortfolioData/PortfolioDataObjects.sol";
import { PortfolioNFT } from "./PortfolioNFT.sol";



/**
 * @notice - This is the storage contract for Portfolio's
 */
contract PortfolioData {

    address[] public portfolioAddresses;
    PortfolioDataStorages PortfolioDataStoragesContract;

    constructor( PortfolioDataStorages _PortfolioDataStoragesContract)  public {
        PortfolioDataStoragesContract = _PortfolioDataStoragesContract ;
    }



    


    /**
     * @notice - Save metadata of a Portfolio
     */
    function saveMetadataOfPortfolioNFT(

        address _portfolioNFT, 
        address _ownerAddress,
        string memory _Name, 
        string memory _Symbol, 
        string memory _description,
        address[] memory _assetsNames,
        uint256[] memory _assetsValues,
        address[] memory _strategy,
        uint256[] memory _yield
    ) public returns (bool) {
        /// Save metadata of a Portfolio 
 

        PortfolioDataObjects.PortfolioTemplate memory portfolioTemplate = PortfolioDataObjects.PortfolioTemplate({
        portfolioNFT: _portfolioNFT,
        owner :_ownerAddress, 
        nameNFT: _Name, 
        symbolNFT: _Symbol,
        description: _description,
        assetsNames: _assetsNames,
        assetsValues: _assetsValues,
        strategy : _strategy,
        yield : _yield 
        });
        PortfolioDataStoragesContract.add(portfolioTemplate);

        /// Update PortfolioAddresses
          portfolioAddresses.push(_portfolioNFT);
   
    }





    ///-----------------
    /// Getter methods
    ///-----------------
    function getPortfolio(uint index) public view returns (PortfolioDataObjects.PortfolioTemplate memory _portfolio) {
        PortfolioDataObjects.PortfolioTemplate memory portfolioTemp = PortfolioDataStoragesContract.getPortfolioIndex(index);
        return portfolioTemp;
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

    function getPortfolioByAddress(address portfolio) public view returns (PortfolioDataObjects.PortfolioTemplate memory _portfolio) {
        //address PORTFOLIO = address(portfolio);

        /// Identify member's index
        uint portfolioIndex;
        for (uint i=0; i < portfolioAddresses.length; i++) {
            if (portfolioAddresses[i] == portfolio) {
                portfolioIndex = i;
            }
        }

        PortfolioDataObjects.PortfolioTemplate memory portfolioX = PortfolioDataStoragesContract.getPortfolioIndex(portfolioIndex);
        return portfolioX;
    }

    function getAllPortfolios() public view returns (PortfolioDataObjects.PortfolioTemplate[] memory _portfolios) {
        return PortfolioDataStoragesContract.getAllPortfoliosTemplate() ;
    }

}
