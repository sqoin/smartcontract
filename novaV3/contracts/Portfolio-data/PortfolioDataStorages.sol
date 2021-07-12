pragma solidity >=0.4.22 <0.9.0;

import { PortfolioDataObjects } from "./PortfolioDataObjects.sol";


// shared storage
contract PortfolioDataStorages is PortfolioDataObjects {

    Portfolio[] public portfolios;

}

