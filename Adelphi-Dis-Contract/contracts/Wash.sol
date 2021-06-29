pragma solidity >=0.4.22 <0.9.0;

import "./IAdministrator.sol";


contract Wash {


    mapping ( string => string) washs ; 


    address AdministratorAddress;

    
    event washAdded(string idWash);
    event washUpdated(string idWash  , string updateWash);


  constructor(address admin ) public {
  
    AdministratorAddress = admin;

  }



    modifier onlyAdminOrUser(){
      require((IAdministrator(AdministratorAddress).isAdmin(msg.sender)||(IAdministrator(AdministratorAddress).isUser(msg.sender)))
      ,"you do not have the right to do this action");
      _;
    }

  function addWash(string memory a , string memory x ) public onlyAdminOrUser {
     washs[x] = a ;
     emit washAdded(x);
  }

  function getWash (string memory b ) public view returns (string memory ){
      return washs[b];
  }

  function updateWash(string memory a , string memory id) public onlyAdminOrUser {
     // washs[id] = a ;
    string memory isFound = getWash(id);
    if (bytes(isFound).length < 1)
    {
      addWash(a, id);
    }
    emit washUpdated(id , a);
  }

  
}