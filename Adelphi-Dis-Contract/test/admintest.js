

const Administrators = artifacts.require("Administrators");
const truffleAssert = require('truffle-assertions');

contract("Administrators" , function(accounts) {

    describe("test functions of administrator" , function() {

        var AdministratorsContract;
        var adminAddress = accounts[0];

        beforeEach( async function() {
            AdministratorsContract = await Administrators.new({from: adminAddress});
        });

         it("test add admin from admin" , async function() {
            await AdministratorsContract.addAdmin(accounts[1] ,"Alice",  {from: adminAddress})
           let isAdmin = await AdministratorsContract.isAdmin(accounts[1]);
           assert.equal(isAdmin, true);
        });


        it("test add admin from non admin user" , async function() {
            await truffleAssert.reverts(
               AdministratorsContract.addAdmin(accounts[1] , "Alice", {from: accounts[2]})
               ,"only Admin can do this action");
            
        });

          it("test remove Admin from admin" , async function() {
            await AdministratorsContract.removeAdmin(accounts[1] ,  {from: adminAddress})
            let isAdmin = await AdministratorsContract.isAdmin(accounts[1]);
           assert.equal(isAdmin, false);
        });


        it("test remove Admin from non admin" , async function() {
                await truffleAssert.reverts(
                AdministratorsContract.removeAdmin(accounts[1] ,  {from: accounts[2]})
                ,"only Admin can do this action");
        });
        

        it("test add user from admin" , async function() {
            await AdministratorsContract.addUser(accounts[1] ,"Bob",  {from: adminAddress})
            let isUser = await AdministratorsContract.isUser(accounts[1]);
            assert.equal(isUser, true);
        });

        it("test add user from non admin user" , async function() {
            await truffleAssert.reverts(
            AdministratorsContract.addUser(accounts[1] , "Bob", {from: accounts[2]})
            ,"only Admin can do this action");
        });


        it("test remove user from admin" , async function() {
            await AdministratorsContract.removeUser(accounts[1] ,  {from: adminAddress})
            let isUser = await AdministratorsContract.isUser(accounts[1]);
           assert.equal(isUser, false);
        });

        it("test remove user from non admin" , async function() {
            await truffleAssert.reverts(
            AdministratorsContract.removeUser(accounts[1] ,  {from: accounts[2]})
            ,"only Admin can do this action");
        });


    })
});



