

const Administrators = artifacts.require("Administrators");
const mash = artifacts.require("Mashing");


const truffleAssert = require('truffle-assertions');



contract("mash"  , function(accounts) {


    describe("test functions for mash" , function() {

    var AdministratorsContract ;
    var MashContract ;
    var adminAddress =  accounts[0];
    var adminAddress2 = accounts[3];
    var userAddress =  accounts[1];
    var outSider =  accounts[2] ;

        beforeEach( async function() {

            AdministratorsContract = await Administrators.new({from: adminAddress});
            await AdministratorsContract.addAdmin(adminAddress2 , "Alice", {from: adminAddress});
            await AdministratorsContract.addUser(userAddress , "Bob",  {from: adminAddress});
            MashContract = await mash.new(AdministratorsContract.address , {from: adminAddress});
        });


         it("test add mash by admin" , async function() {
             let mashTest = "2 bottle of water "
             let  result = await MashContract.addMashing(mashTest , 125,  {from: adminAddress})
             let getMash = await MashContract.getMashing(125);
             assert.equal(getMash, mashTest);
        });


       
         it("test add mash by non admin" , async function() {
            let mashTest = "2 bottle of water "
             await truffleAssert.reverts(
                    MashContract.addMashing(mashTest ,125, {from: accounts[2]})
            ,"you do not have the right to do this action");        
        });


            
         it("test update mash by admin" , async function() {
            let mashTest = "3 bottle of water "
            let nbreBloc = 125;
            let result = await MashContract.updateMashing(mashTest , nbreBloc , {from: adminAddress})
            let getMash = await MashContract.getMashing(125);
            assert.equal(getMash, mashTest);
       });

       
      
        it("test update mash by non admin" , async function() {
            let mashTest = "3 bottle of water "
               let nbreBloc = 125 ;
               await truffleAssert.reverts(
                MashContract.updateMashing(mashTest , nbreBloc, {from: outSider})
               ,"you do not have the right to do this action");    
        });

        


        it("test add mash by admin where he lose his role" , async function() {
            let mashTest = "2 bottle of water "
            let idMash=125
            let  result = await MashContract.addMashing(mashTest ,idMash,  {from: adminAddress2})
            let getMash = await MashContract.getMashing(idMash);
            assert.equal(getMash, mashTest);
            let res =  await AdministratorsContract.removeAdmin(adminAddress2 ,  {from: adminAddress})
            await truffleAssert.reverts(
                MashContract.addMashing(mashTest ,126,  {from: adminAddress2})
            ,"you do not have the right to do this action");
            
        });

     




    })
});


