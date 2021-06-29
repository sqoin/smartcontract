

const Administrators = artifacts.require("Administrators");
const Prescription = artifacts.require("Prescription");


const truffleAssert = require('truffle-assertions');



contract("Prescription"  , function(accounts) {


    describe("test functions for prescription" , function() {

    var AdministratorsContract ;
    var PrescriptionContract ;

        beforeEach( async function() {

           // AdministratorsContract =  await Administrators.new({from: accounts[0]});
            AdministratorsContract =  await Administrators.new({from: accounts[0]});
            await AdministratorsContract.addDoctor(accounts[1] ,  {from: accounts[0]})
           await  AdministratorsContract.addPharmacist(accounts[2] ,  {from: accounts[0]})
            PrescriptionContract = await Prescription.new({from: accounts[0]});
            //PrescriptionContract = await Prescription.at("0xB04a6aC4f2d7d4f69fAcF3231F7941aC360892F8")
        });


         it("test add prescription by doctor" , async function() {
             let pres = "2 comprimées de panadoles par jours "
             let  result = await PrescriptionContract.addPrescription(pres ,  {from: accounts[1]})
             let getPres = await PrescriptionContract.getPrescription(result.logs[0].args.sequence.toString());
             assert.equal(getPres, pres);
        });

       
            it("test add prescription by non doctor" , async function() {
                let pres = "2 comprimées de panadoles par jours "
                await truffleAssert.reverts(
                    PrescriptionContract.addPrescription(pres ,  {from: accounts[2]})
                ,"only Doctors can do this action");
                
            });



            
         it("test update prescription by Pharmacist" , async function() {
            let pres = "2 comprimées de panadoles par jours validé ";
            let nbreBloc = 1254212355;
            let  result = await PrescriptionContract.updatePrescription(pres , nbreBloc , {from: accounts[2]})
            let getPres = await PrescriptionContract.getPrescription(result.logs[0].args.sequence.toString());
            assert.equal(getPres, pres);
       });

      
          it("test update prescription by non Pharmacist" , async function() {
               let pres = "2 comprimées de panadoles par jours validé ";
               let nbreBloc = 1254212355 ;
               await truffleAssert.reverts(
                   PrescriptionContract.updatePrescription(pres , nbreBloc, {from: accounts[1]})
               ,"only Pharmacists can do this action");
               
           });


           it("test add prescription by doctor where he lose his role" , async function() {
            let pres = "2 comprimées de panadoles par jours "

            let  result = await PrescriptionContract.addPrescription(pres ,  {from: accounts[1]})
            let getPres = await PrescriptionContract.getPrescription(result.logs[0].args.sequence.toString());
            assert.equal(getPres, pres);

           let res =  await AdministratorsContract.removeDoctor(accounts[1] ,  {from: accounts[0]})
            await truffleAssert.reverts(
                PrescriptionContract.addPrescription(pres ,  {from: accounts[1]})
            ,"only Doctors can do this action");
            
            });

            it("test update prescription by Pharmacist where he lose his role" , async function() {
                let pres = "2 comprimées de panadoles par jours validé "
                let nbreBloc = 1254212355 ;
                let  result = await PrescriptionContract.updatePrescription(pres , nbreBloc, {from: accounts[2]})
                let getPres = await PrescriptionContract.getPrescription(result.logs[0].args.sequence.toString());
                assert.equal(getPres, pres);
    
                let res =  await AdministratorsContract.removePharmacist(accounts[2] ,  {from: accounts[0]})
                await truffleAssert.reverts(
                    PrescriptionContract.updatePrescription(pres ,nbreBloc ,  {from: accounts[2]})
                ,"only Pharmacists can do this action");
                
                });




    })
});


