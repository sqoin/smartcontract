
const Administrators = artifacts.require("Administrators");
const WesharishTokenDonation = artifacts.require("WesharishTokenDonation");
const WesharishTokenVaccine = artifacts.require("WesharishTokenVaccine");

module.exports = async function(_deployer , accounts) {

   await _deployer.deploy(Administrators);
  
   let admin = await Administrators.deployed();

  await _deployer.deploy(WesharishTokenDonation, admin.address);

  await _deployer.deploy(WesharishTokenVaccine , admin.address);
};
