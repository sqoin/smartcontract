var Token = artifacts.require("./Token.sol");
var Sale = artifacts.require("./Sale.sol");

module.exports = function(deployer) {
	deployer.deploy(Sale, "0x22d505DCC5a360e6679210415b81Fb891C28Fba8").then(function() {
		return deployer.deploy(Token, Sale.address);
	});
};
