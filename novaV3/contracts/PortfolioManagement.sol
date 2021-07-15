pragma solidity 0.6.8;
pragma experimental ABIEncoderV2;

import { PortfolioDataStorages } from "./PortfolioData/PortfolioDataStorages.sol";
import { PortfolioNFT } from "./PortfolioNFT.sol";
import { PortfolioData } from "./PortfolioData.sol";


/**
 * @notice - This is the storage contract for Portfolio's
 */
contract PortfolioManagement is PortfolioDataStorages  {


    PortfolioData portfolioData ;

   event PortfolioNFTCreated(address , address , string , string , string , address[] , uint256[]  , address[] , uint256[] );

    constructor(PortfolioData _portfolioData) public {
        portfolioData = _portfolioData;
    }



    
    /**
     * @notice - Create a new portfolioNFT 
     */
    function createNewPortfolioNFT( string memory nameNFT , string memory symbolNFT , string memory description , address[] memory assetsNames,
        uint256[] memory assetsValues , address[] memory strategy,  uint256[] memory yield
        ) public returns (bool) {
        address owner = msg.sender;  
        /// [Note]: Initial owner of photoNFT is msg.sender
        PortfolioNFT portfolioNFT = new PortfolioNFT(owner, nameNFT, symbolNFT );
      
        /// Save metadata of a photoNFT created
        portfolioData.saveMetadataOfPortfolioNFT(address(portfolioNFT),  owner , nameNFT, symbolNFT , description , assetsNames , assetsValues , strategy , yield );
   

        emit PortfolioNFTCreated(msg.sender, address(portfolioNFT), nameNFT, symbolNFT,  description , assetsNames, assetsValues, strategy, yield);
    }




}
