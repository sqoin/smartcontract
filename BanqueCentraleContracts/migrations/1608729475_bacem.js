
// const DTCoin = artifacts.require("DTCoin");
// const EURCoin = artifacts.require("EURCoin");
// const USDCoin = artifacts.require("USDCoin");
//const Coinsence = artifacts.require("Coinsence");
const coinTest = artifacts.require("coinTest");

module.exports = async function(_deployer , accounts) {

  // await _deployer.deploy(DTCoin);

  // await _deployer.deploy(EURCoin);

  // await _deployer.deploy(USDCoin);

 // await _deployer.deploy(Coinsence);
 
    await _deployer.deploy(coinTest);
 
};
