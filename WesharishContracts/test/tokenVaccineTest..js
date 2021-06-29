const TokenVaccine = artifacts.require("WesharishTokenVaccine");
const Administrators = artifacts.require("Administrators");

const truffleAssert = require('truffle-assertions');
var bn = require("bn.js");
const b18 = "000000000000000000";

contract("TokenVaccine", function (accounts) {




    describe("test functions for Token Vaccine", function () {

        var AdministratorsContract;
        var TokenVaccineContract;

        var amount = new bn("20" + b18, 10)

        var adminAccount = accounts[0];
        var ngoAccount = accounts[1];
        var vendorAccount = accounts[2];
        var userAccount = accounts[3];
        var tokenAccount = accounts[4];
        var vaccinAccount = accounts[5];

        beforeEach(async function () {

            AdministratorsContract = await Administrators.new({ from: adminAccount });
            await AdministratorsContract.addNgo(ngoAccount, { from: adminAccount })
            await AdministratorsContract.addVendor(vendorAccount, { from: ngoAccount })
            await AdministratorsContract.addUser(userAccount, { from: ngoAccount })
            await AdministratorsContract.addVaccinTeam(vaccinAccount, { from: ngoAccount })
            TokenVaccineContract = await TokenVaccine.new(AdministratorsContract.address, { from: adminAccount });
        });


        it("test mint token vaccine by  admin", async function () {
            await TokenVaccineContract.mint(tokenAccount, amount, { from: ngoAccount })
            let Balance = await TokenVaccineContract.balanceOf(tokenAccount);
            assert.equal(Balance,amount.toString());
        });

        it("test mint token by non admin", async function () {
            await truffleAssert.reverts(
                TokenVaccineContract.mint(tokenAccount, amount, { from: vendorAccount })
                , "only admin can do this action");
        });


        it("test burn token vaccine by  admin", async function () {
            await TokenVaccineContract.mint(tokenAccount, amount, { from: ngoAccount })
            let BalanceFirst = await TokenVaccineContract.balanceOf(tokenAccount);
            await TokenVaccineContract.approve(ngoAccount , amount , {from: tokenAccount} );
            console.log  ("BalanceFirst"+BalanceFirst);
            let result = await TokenVaccineContract.burnToken(tokenAccount, amount, { from: ngoAccount })
            let Balance = await TokenVaccineContract.balanceOf(tokenAccount);
            console.log ("balance"+Balance);
            assert.equal(Balance, 0);
        });

        it("test burn token vaccine by  vaccinTeam", async function () {
            await TokenVaccineContract.mint(tokenAccount, amount, { from: ngoAccount })
            let BalanceFirst = await TokenVaccineContract.balanceOf(tokenAccount);
            await TokenVaccineContract.approve(vaccinAccount , amount , {from: tokenAccount} );
            console.log  ("BalanceFirst"+BalanceFirst);
            let result = await TokenVaccineContract.burnToken(tokenAccount, amount, { from: vaccinAccount })
            let Balance = await TokenVaccineContract.balanceOf(tokenAccount);
            console.log ("balance"+Balance);
            assert.equal(Balance, 0);
        });      
        
        

        it("test burn token by non admin , non vaccinTeam", async function () {
            await TokenVaccineContract.mint(tokenAccount, amount, { from: ngoAccount })
            let BalanceFirst = await TokenVaccineContract.balanceOf(tokenAccount);
            await TokenVaccineContract.approve(userAccount , amount , {from: tokenAccount} );
            console.log  ("BalanceFirst"+BalanceFirst);
            await truffleAssert.reverts(
                TokenVaccineContract.burnToken(tokenAccount, amount, { from: userAccount })
                , "you do not have the right to do this action");
        });





    });
})