pragma solidity >=0.4.22 <0.9.0;
import { PortfolioNFT } from "../Portfolio.sol";


contract PortfolioDataObjects {

    struct Portfolio {  /// [Key]: index of array
        PortfolioNFT portfolioNFT,
        address owner,   
        string memory NameNFT, 
        string memory portfolioNFTSymbol,
        string memory description,
        string memory creatorName ,
        string memory twitterLink ,
        string memory redditLink ,
        string memory tradingviewLink
    }

}
