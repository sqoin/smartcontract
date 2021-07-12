pragma solidity >=0.4.22 <0.9.0;
import { PortfolioNFT } from "../PortfolioNFT.sol";


contract PortfolioDataObjects {

    struct Portfolio {  /// [Key]: index of array
        PortfolioNFT portfolioNFT;
        address owner;   
        string  nameNFT; 
        string  symbolNFT;
        string  description;
    }

}
