const PortfolioNFT = artifacts.require("PortfolioNFT");
const PortfolioDataObjects = artifacts.require("PortfolioDataObjects");
const PortfolioDataStorages = artifacts.require("PortfolioDataStorages");
const PortfolioData = artifacts.require("PortfolioData");
const PortfolioManagement = artifacts.require("PortfolioManagement");

module.exports = async function(_deployer) {
   
  // await _deployer.deploy(PortfolioNFT);
   await _deployer.deploy(PortfolioDataObjects);
   await _deployer.deploy(PortfolioDataStorages);
   await _deployer.deploy(PortfolioData);
   let portfolioData = await PortfolioData.deployed();
   await _deployer.deploy(PortfolioManagement, portfolioData.address);
 
  
};
