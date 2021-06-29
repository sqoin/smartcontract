//const nAssets = artifacts.require("nAssets");
var ValidatedTokenEuro = artifacts.require("ValidatedTokenEuro");

module.exports = async  function(deployer) {
 // deployer.deploy(nAssets);
  await deployer.deploy(ValidatedTokenEuro, "0xB1014cF81c00caEb30534e0f90995Be726f8B36C","0x11e1EB556F3d5817676Fc97D033a29d55282095C","0x22d505DCC5a360e6679210415b81Fb891C28Fba8");

};
