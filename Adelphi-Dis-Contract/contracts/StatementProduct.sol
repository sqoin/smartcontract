pragma solidity >=0.4.22 <0.9.0;

import "./IAdministrator.sol";


contract StatementProduct {


    mapping ( string => string) statementProducts ; 


    address AdministratorAddress;

    
    event statementProductAdded(string idStatementProduct);
    event statementProductUpdated(string idStatementProduct , string updateStatementProduct );


  constructor(address admin ) public {
  
    AdministratorAddress = admin;

  }



    modifier onlyAdminOrUser(){
      require((IAdministrator(AdministratorAddress).isAdmin(msg.sender)||(IAdministrator(AdministratorAddress).isUser(msg.sender)))
      ,"you do not have the right to do this action");
      _;
    }

  function addStatementProduct(string memory a , string memory id ) public onlyAdminOrUser {
     statementProducts[id] = a ;
     emit statementProductAdded(id);
  }

  function getStatementProduct (string memory b ) public view returns (string memory ){
      return statementProducts[b];
  }

  function updateStatementProduct(string memory a , string memory id) public onlyAdminOrUser {
    //  statementProducts[id] = a ;
        string memory isFound = getStatementProduct(id);
    if (bytes(isFound).length < 1)
    {
      addStatementProduct(a, id);
    }
    emit statementProductUpdated(id , a);
  }

  
}