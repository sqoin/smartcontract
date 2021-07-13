

const PortfolioNFT = artifacts.require("PortfolioNFT");
const PortfolioDataObjects = artifacts.require("PortfolioDataObjects");
const PortfolioDataStorages = artifacts.require("PortfolioDataStorages");
const PortfolioData = artifacts.require("PortfolioData");
const PortfolioManagement = artifacts.require("PortfolioManagement");



//const truffleAssert = require('truffle-assertions');


contract("PortfolioManagement" , function(accounts) {

    describe("test  portfolio" , function() {

        var PortfolioManagementContract;

        beforeEach( async function() {
           // PortfolioNFTContract = await PortfolioNFT.new({from: accounts[0]});
            PortfolioDataObjectsContract = await PortfolioDataObjects.new({from: accounts[0]});
            PortfolioDataStoragesContract = await PortfolioDataStorages.new({from: accounts[0]});
            PortfolioDataContract = await PortfolioData.new({from: accounts[0]});
            PortfolioManagementContract = await PortfolioManagement.new(PortfolioDataContract.address,{from: accounts[0]});
            
  
        });


         it("test add new portfolio" , async function() {
   
             let res1 = await PortfolioManagementContract.createNewPortfolioNFT("jawaherkorbosli", "jk","description",  {from: accounts[0]})
            
             let res = await PortfolioDataContract.getAllPortfolios( )
             console.log ("res : "+JSON.stringify(res));
              //assert.equal("jawaherkorbosli", res.nameNFT);
              assert.equal(res[0].nameNFT, "jawaherkorbosli");
        });

         it("test getPortfolio" , async function() {
           
             let res1 = await PortfolioManagementContract.createNewPortfolioNFT("jawaherkorbosli", "jk","description",  {from: accounts[0]})
            
             let res = await PortfolioDataContract.getPortfolio("0", {from: accounts[0]} )
             console.log ("res : "+JSON.stringify(res));
              //assert.equal("jawaherkorbosli", res.nameNFT);
              assert.equal(res.nameNFT, "jawaherkorbosli");
        });


         it("test get Portfolio By Address" , async function() {
           
             await PortfolioManagementContract.createNewPortfolioNFT("jawaherkorbosli", "jk","description",  {from: accounts[0]})
             let res2 = await PortfolioDataContract.getAllPortfolios( );

             let res3 = await PortfolioDataContract.getPortfolioByAddress(res2[0].portfolioNFT, {from: accounts[0]} )
             console.log ("res3 : "+JSON.stringify(res3));
              //assert.equal("jawaherkorbosli", res.nameNFT);
              assert.equal(res3.nameNFT, "jawaherkorbosli");
        });


         it("test get Portfolio Index" , async function() {
           
             await PortfolioManagementContract.createNewPortfolioNFT("jawaherkorbosli", "jk","description",  {from: accounts[0]})
             let res2 = await PortfolioDataContract.getAllPortfolios( );

             let res3 = await PortfolioDataContract.getPortfolioIndex(res2[0].portfolioNFT, {from: accounts[0]} )
             console.log ("res3 : "+JSON.stringify(res3));
              //assert.equal("jawaherkorbosli", res.nameNFT);
              assert.equal(res3, "0");
        });


      


    })
});



