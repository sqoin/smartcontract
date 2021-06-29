pragma solidity >=0.4.22 <0.9.0;

import "./IAdministrator.sol";


contract Spirit {


    mapping ( string => string) spirits ; 


    address AdministratorAddress;

    
    event spiritAdded(string idSpirit);
    event spiritUpdated(string idSpirit ,string updateSpirit );


  constructor(address admin ) public {
  
    AdministratorAddress = admin;
  }



    modifier onlyAdminOrUser(){
      require((IAdministrator(AdministratorAddress).isAdmin(msg.sender)||(IAdministrator(AdministratorAddress).isUser(msg.sender)))
      ,"you do not have the right to do this action");
      _;
    }

  function addSpirit(string memory a , string memory id ) public onlyAdminOrUser {
    spirits[id] = a ;
    emit spiritAdded( id);
  }

  function getSpirit (string memory b ) public view returns (string memory ){
      return spirits[b];
  }

  function updateSpirit(string memory a , string memory id) public onlyAdminOrUser {
    //spirits[id] = a ;
       string memory isFound = getSpirit(id);
    if (bytes(isFound).length < 1)
    {
      addSpirit(a, id);
    }
    emit spiritUpdated(id , a);
  }

  
}