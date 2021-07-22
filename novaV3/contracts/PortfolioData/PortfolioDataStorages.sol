pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

import { PortfolioDataObjects } from "./PortfolioDataObjects.sol";


// shared storage
contract PortfolioDataStorages is PortfolioDataObjects {

    PortfolioTemplate[] public portfoliosTemplate;



    function add(PortfolioTemplate memory _portfolioTemplate) public {
        portfoliosTemplate.push(_portfolioTemplate);
    }

    function getPortfolioIndex ( uint256 index) public view returns (PortfolioTemplate memory _portfolioTemp) {
        return portfoliosTemplate[index];
    }

    function getAllPortfoliosTemplate () public view  returns (PortfolioTemplate[] memory _portfoliosTemp) {
        return portfoliosTemplate ;
    }

}

