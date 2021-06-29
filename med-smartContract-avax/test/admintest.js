

const Administrators = artifacts.require("Administrators");


const truffleAssert = require('truffle-assertions');


contract("Administrators" , function(accounts) {

    describe("test functions of administrator" , function() {

        var AdministratorsContract;

        beforeEach( async function() {

            AdministratorsContract = await Administrators.new({from: accounts[0]});
  
        });


         it("test add admin from admin" , async function() {
            await AdministratorsContract.addAdmin(accounts[1] ,  {from: accounts[0]})
           let isAdmin = await AdministratorsContract.isAdmin(accounts[1]);
           assert.equal(isAdmin, true);
        });


        it("test add admin from non admin user" , async function() {
            await truffleAssert.reverts(
               AdministratorsContract.addAdmin(accounts[1] ,  {from: accounts[2]})
               ,"only admin can do this action");
            
        });

          it("test remove Admin from admin" , async function() {
            await AdministratorsContract.removeAdmin(accounts[1] ,  {from: accounts[0]})
            let isAdmin = await AdministratorsContract.isAdmin(accounts[1]);
           assert.equal(isAdmin, false);
        });


            it("test remove Admin from non admin" , async function() {
                await truffleAssert.reverts(
                AdministratorsContract.removeAdmin(accounts[1] ,  {from: accounts[2]})
                ,"only admin can do this action");
            });
        

        it("test add doctor from admin" , async function() {
            await AdministratorsContract.addDoctor(accounts[1] ,  {from: accounts[0]})
            let isDoctor = await AdministratorsContract.isDoctor(accounts[1]);
            assert.equal(isDoctor, true);
        });

        it("test add doctor from non admin user" , async function() {
            await truffleAssert.reverts(
            AdministratorsContract.addDoctor(accounts[1] ,  {from: accounts[2]})
            ,"only admin can do this action");
        });


        it("test remove doctor from admin" , async function() {
            await AdministratorsContract.removeDoctor(accounts[1] ,  {from: accounts[0]})
            let isDoctor = await AdministratorsContract.isDoctor(accounts[1]);
           assert.equal(isDoctor, false);
        });

        it("test remove doctor from non admin" , async function() {
            await truffleAssert.reverts(
            AdministratorsContract.removeDoctor(accounts[1] ,  {from: accounts[2]})
            ,"only admin can do this action");
        });

        it("test add pharmacist from admin" , async function() {
            await AdministratorsContract.addPharmacist(accounts[1] ,  {from: accounts[0]})
            let isPharmacist =  await AdministratorsContract.isPharmacist(accounts[1]);
            assert.equal(isPharmacist, true);
        });

        it("test add Pharmacist from non admin user" , async function() {
            await truffleAssert.reverts(
            AdministratorsContract.addPharmacist(accounts[1] ,  {from: accounts[2]})
            ,"only admin can do this action");
        });
        
        it("test remove Pharmacist from admin" , async function() {
            await AdministratorsContract.removePharmacist(accounts[1] ,  {from: accounts[0]})
            let isPharmacist = await AdministratorsContract.isPharmacist(accounts[1]);
           assert.equal(isPharmacist, false);
        });

        it("test remove Pharmacist from non admin" , async function() {
            await truffleAssert.reverts(
            AdministratorsContract.removePharmacist(accounts[1] ,  {from: accounts[2]})
            ,"only admin can do this action");
        });


    })
});



