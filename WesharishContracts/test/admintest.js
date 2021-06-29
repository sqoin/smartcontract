const Administrators = artifacts.require("Administrators");


const truffleAssert = require('truffle-assertions');


contract("Administrators" , function(accounts) {

    describe("test functions of administrator" , function() {

        var AdministratorsContract;

        var superAdminAccount = accounts[0];
        var ngoAccount = accounts[1];
        var vendorAccount = accounts[2];
        var userAccount = accounts[3];
        var vaccinAccount = accounts[7]
        

        beforeEach( async function() {

            AdministratorsContract = await Administrators.new({from: superAdminAccount});
            await AdministratorsContract.addNgo(ngoAccount ,  {from: superAdminAccount})
  
        });

            /********** Super Admin ********/
        it("test add superAdmin from superAdmin" , async function() {
            await AdministratorsContract.addSuperAdmin(vendorAccount ,  {from: superAdminAccount})
           let isSuperAdmin = await AdministratorsContract.isSuperAdmin(vendorAccount);
           assert.equal(isSuperAdmin, true);
        });


        it("test add super admin from non super admin user" , async function() {
            await truffleAssert.reverts(
               AdministratorsContract.addSuperAdmin(vendorAccount ,  {from: userAccount})
               ,"only super admin can do this action");
            
        });

        it("test remove super Admin from super admin" , async function() {
            await AdministratorsContract.removeSuperAdmin(ngoAccount ,  {from: superAdminAccount})
            let isSuperAdmin = await AdministratorsContract.isSuperAdmin(ngoAccount);
           assert.equal(isSuperAdmin, false);
        });


        it("test remove super Admin from non super admin" , async function() {
                await truffleAssert.reverts(
                AdministratorsContract.removeSuperAdmin(ngoAccount ,  {from: vendorAccount})
                ,"only super admin can do this action");
        });
        


                 /********** NGOS ********/
        it("test add ngo from superAdmin" , async function() {
            await AdministratorsContract.addNgo(ngoAccount ,  {from: superAdminAccount})
           let isNgo = await AdministratorsContract.isNgo(ngoAccount);
           assert.equal(isNgo, true);
        });


        it("test add ngo from non super admin user" , async function() {
            await truffleAssert.reverts(
               AdministratorsContract.addNgo(ngoAccount ,  {from: vendorAccount})
               ,"only super admin can do this action");
            
        });

        it("test remove ngo from super admin" , async function() {
            await AdministratorsContract.removeNgo(ngoAccount ,  {from: superAdminAccount})
            let isNgo = await AdministratorsContract.isNgo(ngoAccount);
           assert.equal(isNgo, false);
        });


        it("test remove ngo from non super admin" , async function() {
                await truffleAssert.reverts(
                AdministratorsContract.removeNgo(ngoAccount ,  {from: vendorAccount})
                ,"only super admin can do this action");
        });




               /********** Vendors ********/
        it("test add vendor from ngo" , async function() {
            await AdministratorsContract.addVendor(vendorAccount ,  {from: ngoAccount})
           let isVendor = await AdministratorsContract.isVendor(vendorAccount);
           assert.equal(isVendor, true);
        });


        it("test add vendor from non ngo " , async function() {
            await truffleAssert.reverts(
               AdministratorsContract.addVendor(vendorAccount ,  {from: userAccount})
               ,"only admin can do this action");
            
        });

        it("test remove vendor from ngo " , async function() {
            await AdministratorsContract.removeVendor(vendorAccount ,  {from: ngoAccount})
            let isVendor = await AdministratorsContract.isVendor(vendorAccount);
           assert.equal(isVendor, false);
        });


        it("test remove vendor from non ngo " , async function() {
                await truffleAssert.reverts(
                AdministratorsContract.removeVendor(vendorAccount,  {from: userAccount})
                ,"only admin can do this action");
        });





             /********** Users ********/
        it("test add user from ngo " , async function() {
            await AdministratorsContract.addUser(userAccount ,  {from: ngoAccount})
           let isUser = await AdministratorsContract.isUser(userAccount);
           assert.equal(isUser, true);
        });


        it("test add user from non ngo user" , async function() {
            await truffleAssert.reverts(
               AdministratorsContract.addUser(userAccount ,  {from: vendorAccount})
               ,"only admin can do this action");
            
        });

        it("test remove user from ngo" , async function() {
            await AdministratorsContract.removeUser(userAccount ,  {from: ngoAccount})
            let isUser = await AdministratorsContract.isUser(userAccount);
           assert.equal(isUser, false);
        });


        it("test remove user from non ngo" , async function() {
                await truffleAssert.reverts(
                AdministratorsContract.removeUser(userAccount ,  {from: vendorAccount})
                ,"only admin can do this action");
        });


          /********** vaccinTeam *********/
          it("test add vaccinTeam from ngo " , async function() {
            await AdministratorsContract.addVaccinTeam(vaccinAccount ,  {from: ngoAccount})
           let isUser = await AdministratorsContract.isVaccinTeam(vaccinAccount);
           assert.equal(isUser, true);
        });


        it("test add vaccinTeam from non ngo user" , async function() {
            await truffleAssert.reverts(
               AdministratorsContract.addVaccinTeam(vaccinAccount ,  {from: vendorAccount})
               ,"only admin can do this action");
            
        });

        it("test remove vaccinTeam from ngo" , async function() {
            await AdministratorsContract.removeVaccinTeam(vaccinAccount ,  {from: ngoAccount})
            let isUser = await AdministratorsContract.isVaccinTeam(vaccinAccount);
           assert.equal(isUser, false);
        });


        it("test remove vaccinTeam from non ngo" , async function() {
                await truffleAssert.reverts(
                AdministratorsContract.removeVaccinTeam(vaccinAccount ,  {from: vendorAccount})
                ,"only admin can do this action");
        });

        

    })
});



