const Portfolio = artifacts.require("PortfolioManagement");

module.exports = async function(_deployer) {
   
   await _deployer.deploy(Portfolio);
 
  
};
