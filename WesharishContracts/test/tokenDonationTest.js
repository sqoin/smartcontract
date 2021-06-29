const TokenDonation = artifacts.require("WesharishTokenDonation");
const Administrators = artifacts.require("Administrators");

const truffleAssert = require('truffle-assertions');
var bn = require("bn.js");
const b18 = "000000000000000000";
contract("TokenDonation", function (accounts) {




    describe("test functions for Token Vaccine", function () {

        var AdministratorsContract;
        var TokenDonationContract;
        var amount = new bn("20" + b18, 10)

        var adminAccount = accounts[0];
        var ngoAccount = accounts[1];
        var vendorAccount = accounts[2];
        var userAccount = accounts[3];
        var tokenAccount = accounts[4];


        beforeEach(async function () {

            AdministratorsContract = await Administrators.new({ from: adminAccount});
            await AdministratorsContract.addNgo(ngoAccount, { from: adminAccount });
            await AdministratorsContract.addVendor(vendorAccount, { from: ngoAccount });
            await AdministratorsContract.addUser(userAccount, { from: ngoAccount });
            TokenDonationContract = await TokenDonation.new(AdministratorsContract.address, { from: adminAccount });
        });


        it("test mint token donation by  admin", async function () {
            await TokenDonationContract.mint(tokenAccount, amount, { from: ngoAccount })
            let Balance = await TokenDonationContract.balanceOf(tokenAccount);
            assert.equal(Balance,amount.toString());
        });

        it("test mint token by non admin", async function () {
            await truffleAssert.reverts(
            TokenDonationContract.mint(tokenAccount, amount, { from: vendorAccount })
            , "only admin can do this action");
        });


        it("test burn token donation by  ngo", async function () {
            console.log ("debut")
            let Balance1 = await TokenDonationContract.balanceOf(ngoAccount);
            let Balance2 = await TokenDonationContract.balanceOf(tokenAccount);
            console.log ("account ngo : "+Balance1);
            console.log ("token account : "+Balance2);
           
            await TokenDonationContract.mint(tokenAccount, amount, { from: ngoAccount })
            let Balance3 = await TokenDonationContract.balanceOf(ngoAccount);
            let Balance4 = await TokenDonationContract.balanceOf(tokenAccount);
            console.log ("mint token account")
            console.log ("account ngo : "+Balance3);
            console.log ("token account : "+Balance4);
            await TokenDonationContract.approve(ngoAccount , amount , {from: tokenAccount} );
            let Balance5 = await TokenDonationContract.balanceOf(ngoAccount);
            let Balance6 = await TokenDonationContract.balanceOf(tokenAccount);
            console.log ("approuve ")
            console.log ("account ngo : "+Balance5);
            console.log ("token account : "+Balance6);
             await TokenDonationContract.transfer(ngoAccount, (new bn("10"+b18,10)) , { from: tokenAccount });
            let Balance7 = await TokenDonationContract.balanceOf(ngoAccount);
            let Balance8 = await TokenDonationContract.balanceOf(tokenAccount);
            console.log ("transfer from token address to ngo ")
            console.log ("account ngo : "+Balance7);
            console.log ("token account : "+Balance8);
            let result = await TokenDonationContract.burnToken(tokenAccount, (new bn("10"+b18,10)), { from: ngoAccount })
            let Balance9 = await TokenDonationContract.balanceOf(ngoAccount);
            let Balance10 = await TokenDonationContract.balanceOf(tokenAccount);
            console.log ("burn token account")
            console.log ("account ngo : "+Balance9);
            console.log ("token account : "+Balance10);
           // let Balance = await TokenDonationContract.balanceOf(tokenAccount);
           // console.log ("balance :"+Balance)
            assert.equal(Balance10, 0);
        });


        it("test burn token donation by  vendor", async function () {
            await TokenDonationContract.mint(tokenAccount, amount, { from: ngoAccount })
            await TokenDonationContract.approve(vendorAccount , amount , {from: tokenAccount} );
            let result = await TokenDonationContract.burnToken(tokenAccount, amount, { from: vendorAccount })
            let Balance = await TokenDonationContract.balanceOf(tokenAccount);
            console.log ("balance :"+Balance)
            assert.equal(Balance, 0);
        });




        it("test burn token by non ngo , non vendor ", async function () {
            await TokenDonationContract.mint(tokenAccount, amount, { from: ngoAccount })
            await TokenDonationContract.approve(userAccount , amount , {from: tokenAccount} );
            await truffleAssert.reverts(
            TokenDonationContract.burnToken(tokenAccount, amount, { from: userAccount })
            , "you do not have the right to do this action");
        });


        
       
        it("test transfer  by vendor ", async function () {
            await TokenDonationContract.mint(tokenAccount, amount, { from: ngoAccount })
            let result = await TokenDonationContract.balanceOf(tokenAccount)
            await TokenDonationContract.transfer(vendorAccount, (new bn("10"+b18,10)) , { from: tokenAccount });
            let balance = await TokenDonationContract.balanceOf(tokenAccount);
            assert.equal(balance, (new bn("10"+b18,10)).toString());
          
        });


      

    });
})