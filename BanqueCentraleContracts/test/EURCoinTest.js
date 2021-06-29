const EURCoin = artifacts.require("EURCoin");


const truffleAssert = require('truffle-assertions');
var bn = require("bn.js");
const b18 = "000000000000000000";
contract("EURCoin", function (accounts) {




    describe("test functions for EURCoin ", function () {

        var EURCoinContract;
        var ngoAccount = accounts[1];

        beforeEach(async function () {

            EURCoinContract = await EURCoin.new();
          
        });

        it("getBalance", async function () {
        
            let Balance = await EURCoinContract.balanceOf(ngoAccount);
            console.log ("Balance is : " +Balance)
            assert.equal(Balance,0);
        });

    });

})
