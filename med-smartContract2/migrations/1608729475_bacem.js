const bacem = artifacts.require("bacem");
const Administrators = artifacts.require("Administrators");
const Prescription = artifacts.require("Prescription");

module.exports = async function(_deployer) {
 

   await _deployer.deploy(Administrators);
  
   let admin = await Administrators.deployed();

  await _deployer.deploy(Prescription , admin.address);
};
