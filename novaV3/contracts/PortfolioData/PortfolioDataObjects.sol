pragma solidity >=0.4.22 <0.9.0;
import { PortfolioNFT } from "../PortfolioNFT.sol";




contract PortfolioDataObjects    {

    struct Portfolio {  
        address portfolioNFT;
        address owner;   
        string  nameNFT; 
        string  symbolNFT;
        string  description;
        address[] assetsNames;
        uint256[] assetsValues;
        address[] strategy;
        uint256[] yield;
    }

}
