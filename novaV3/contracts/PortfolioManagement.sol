pragma solidity 0.6.8;
pragma experimental ABIEncoderV2;

import { PortfolioDataStorages } from "./PortfolioData/PortfolioDataStorages.sol";
import { PortfolioNFT } from "./PortfolioNFT.sol";
import { PortfolioData } from "./PortfolioData.sol";


/**
 * @notice - This is the storage contract for Portfolio's
 */
contract PortfolioManagement is PortfolioDataStorages  {

    address[] public portfolioAddresses;
    PortfolioData portfolioData ;

   event PortfolioNFTCreated(address , PortfolioNFT , string , string , string  );

    constructor(PortfolioData _portfolioData) public {
        portfolioData = _portfolioData;
    }



    
    /**
     * @notice - Create a new portfolioNFT 
     */
    function createNewPortfolioNFT( 
        Portfolio memory _portfolio ) public returns (bool) {
        address owner = msg.sender;  
        /// [Note]: Initial owner of photoNFT is msg.sender
        PortfolioNFT portfolioNFT = new PortfolioNFT(owner, _portfolio.nameNFT, _portfolio.symbolNFT);
        portfolioAddresses.push(address(portfolioNFT));
        /// Save metadata of a photoNFT created
        portfolioData.saveMetadataOfPortfolioNFT(portfolioNFT,  owner , _portfolio.nameNFT, _portfolio.symbolNFT , _portfolio.description);
   

        emit PortfolioNFTCreated(msg.sender, portfolioNFT, _portfolio.nameNFT, _portfolio.symbolNFT,  _portfolio.description);
    }






  


}
