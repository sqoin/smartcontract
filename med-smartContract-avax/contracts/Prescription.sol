pragma solidity >=0.4.22 <0.9.0;

import "./IAdministrator.sol";


contract Prescription {


  //mapping( uint => address) Prescriptions;
    mapping ( uint => string) Prescriptions ; 

  uint sequence;
  address AdministratorAddress;
  event prescriptionAdded(uint sequence);
  event prescriptionUpdated(uint sequence );


  constructor(address admin ) public {
  
    AdministratorAddress = admin;
    sequence = 1254212354;
  }


  modifier onlyDoctor() {
      require(IAdministrator(AdministratorAddress).isDoctor(msg.sender), "only Doctors can do this action");
      _;
  }

  modifier onlyPharmacist() {
      require(IAdministrator(AdministratorAddress).isPharmacist(msg.sender), "only Pharmacists can do this action");
      _;
  }

  function addPrescription(string memory a ) public onlyDoctor {
    sequence = sequence + 1;
    //Prescriptions[a] = sequence;
    Prescriptions[sequence] = a ;
    emit prescriptionAdded(sequence);
  }

  function getPrescription (uint b ) public view returns (string memory ){
      return Prescriptions[b];
  }

  function updatePrescription(string memory a , uint s) public onlyPharmacist {
    Prescriptions[s] = a ;
    emit prescriptionUpdated(s);
  }

  
}