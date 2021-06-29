const Administrators = artifacts.require("Administrators");
const Mashing = artifacts.require("Mashing");
const Spirit = artifacts.require("Spirit");
const Wash = artifacts.require("Wash");
const Stock = artifacts.require("Stock");
const StatementProduct = artifacts.require("StatementProduct");


module.exports = async function(_deployer) {
   // await _deployer.deploy(Administrators);
  
   // let admin = await Administrators.deployed();

   //await _deployer.deploy(Mashing , '0x7583BDE57C2bA69d3663219B1ee7a0E1c4bCDd9B');
 //  await _deployer.deploy(Mashing , admin.address);
   // await _deployer.deploy(Spirit , admin.address);
   // await _deployer.deploy(Wash , admin.address);
   // await _deployer.deploy(Stock , admin.address);
   // await _deployer.deploy(StatementProduct , admin.address);

   // await _deployer.deploy(Mashing , '0x7C73d3b6cdC4e2e32FdeA227B80ee275aa5D6FCC');
    //await _deployer.deploy(Spirit , '0x7C73d3b6cdC4e2e32FdeA227B80ee275aa5D6FCC');
    await _deployer.deploy(Wash , '0x7C73d3b6cdC4e2e32FdeA227B80ee275aa5D6FCC');
   // await _deployer.deploy(Stock , '0x7C73d3b6cdC4e2e32FdeA227B80ee275aa5D6FCC');
  // await _deployer.deploy(StatementProduct , '0x7C73d3b6cdC4e2e32FdeA227B80ee275aa5D6FCC');
  
};
