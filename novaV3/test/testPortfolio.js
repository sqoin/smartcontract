
const PortfolioNFT = artifacts.require("PortfolioNFT");
const PortfolioDataObjects = artifacts.require("PortfolioDataObjects");
const PortfolioDataStorages = artifacts.require("PortfolioDataStorages");
const PortfolioData = artifacts.require("PortfolioData");
const PortfolioManagement = artifacts.require("PortfolioManagement");



const truffleAssert = require('truffle-assertions');


contract("PortfolioManagement" , function(accounts) {

    describe("test  portfolio" , function() {

        var PortfolioManagementContract;

        beforeEach( async function() {
            PortfolioNFTContract = await PortfolioNFT.new({from: accounts[0]});
            PortfolioDataObjectsContract = await PortfolioDataObjects.new({from: accounts[0]});
            PortfolioDataStoragesContract = await PortfolioDataStorages.new({from: accounts[0]});
            PortfolioDataContract = await PortfolioData.new({from: accounts[0]});
            PortfolioManagementContract = await PortfolioManagement.new(PortfolioDataContract,{from: accounts[0]});
            
  
        });


         it("test add new portfolio" , async function() {
             let portfolioNFT = new PortfolioNFT("0x7120e584fBa8af178d6bdbD95e950943B40E66D8","jawaher","j");
             let struct = { portfolioNFT,owner: "0x7120e584fBa8af178d6bdbD95e950943B40E66D8",nameNFT:"jawaherkorbosli",symbolNFT:"jk",description:"description"}
             await PortfolioManagementContract.createNewPortfolioNFT(struct ,  {from: accounts[0]})
             let res = await PortfolioDataContract.getPortfolio(1 ,  {from: accounts[0]})
        
           assert.equal(struct, res);
        });


      


    })
});
