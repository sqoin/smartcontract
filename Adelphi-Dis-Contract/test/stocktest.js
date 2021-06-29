

const Administrators = artifacts.require("Administrators");
const stock = artifacts.require("Stock");


const truffleAssert = require('truffle-assertions');



contract("Stock"  , function(accounts) {


    describe("test functions for stock" , function() {

    var AdministratorsContract ;
    var stockContract ;
    var adminAddress =  accounts[0];
    var adminAddress2 = accounts[3];
    var userAddress =  accounts[1];
    var outSider =  accounts[2] ;

        beforeEach( async function() {

            AdministratorsContract = await Administrators.new({from: adminAddress});
            await AdministratorsContract.addAdmin(adminAddress2 , "Alice", {from: adminAddress});
            await AdministratorsContract.addUser(userAddress , "Bob",  {from: adminAddress});
            stockContract = await stock.new(AdministratorsContract.address , {from: adminAddress});
        });


         it("test add stock by admin" , async function() {
             let stockTest = "2 bottle of water "
             await stockContract.addStock(stockTest ,  {from: adminAddress})
             let getStock = await stockContract.getStock(123457);
             assert.equal(getStock['0'], stockTest);
        });


       
         it("test add stock by outsider" , async function() {
            let stockTest = "2 bottle of water "
             await truffleAssert.reverts(
                stockContract.addStock(stockTest ,{from: outSider})
            ,"you do not have the right to do this action");        
        });


            
         it("test update stock by admin" , async function() {
            let stockTest = "3 bottle of water "
            let nbreBloc = 123457;
            let result = await stockContract.updateStock(stockTest , nbreBloc , {from: adminAddress})
            let getStock = await stockContract.getStock(nbreBloc);
            assert.equal(getStock['0'], stockTest);
       });

       
      
        it("test update stock by outsider" , async function() {
            let stockTest = "3 bottle of water "
               let nbreBloc = 123457 ;
               await truffleAssert.reverts(
                stockContract.updateStock(stockTest , nbreBloc, {from: outSider})
               ,"you do not have the right to do this action");    
        });

        


        it("test add stock by admin where he lose his role" , async function() {
            let stockTest = "2 bottle of water "
            let idStock=123457
            let  result = await stockContract.addStock(stockTest , {from: adminAddress2})
            let getStock = await stockContract.getStock(idStock);
            assert.equal(getStock['0'], stockTest);
            let res =  await AdministratorsContract.removeAdmin(adminAddress2 ,  {from: adminAddress})
            await truffleAssert.reverts(
                stockContract.addStock(stockTest , {from: adminAddress2})
            ,"you do not have the right to do this action");
            
        });


        it("test deactivate stock by admin" , async function() {
            let nbreBloc = 123457;
            let result = await stockContract.deactivateStock( nbreBloc , {from: adminAddress})
            let getStock = await stockContract.getStock(nbreBloc);
            assert.equal(getStock['1'], true);
       });

        
        it("test deactivate stock by outsider" , async function() {
               let nbreBloc = 123457 ;
               await truffleAssert.reverts(
                stockContract.deactivateStock( nbreBloc, {from: outSider})
               ,"only Admin can do this action");    
        });


        it("test activate stock by admin" , async function() {
            let nbreBloc = 123457;
            let result = await stockContract.activateStock( nbreBloc , {from: adminAddress})
            let getStock = await stockContract.getStock(nbreBloc);
            assert.equal(getStock['1'], false);
       });

        
        it("test activate stock by outsider" , async function() {
               let nbreBloc = 123457 ;
               await truffleAssert.reverts(
                stockContract.activateStock( nbreBloc, {from: outSider})
               ,"only Admin can do this action");    
        });




    })
});


