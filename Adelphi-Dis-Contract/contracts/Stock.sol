pragma solidity >=0.4.22 <0.9.0;

import "./IAdministrator.sol";


contract Stock {


    mapping ( string => string) stocks ; 
    mapping ( string => bool) deactiveStocks ;

    address AdministratorAddress;
    
    event stockAdded(string idStock);
    event stockUpdated(string idStock );
    event deactivateStocktransaction(string idStock);
    event activateStocktransaction(string idStock);


  constructor(address admin ) public {
  
    AdministratorAddress = admin;

  }

    modifier onlyAdmin() {
        require(IAdministrator(AdministratorAddress).isAdmin(msg.sender), "only Admin can do this action");
        _;
    }

    modifier onlyAdminOrUser(){
      require((IAdministrator(AdministratorAddress).isAdmin(msg.sender)||(IAdministrator(AdministratorAddress).isUser(msg.sender)))
      ,"you do not have the right to do this action");
      _;
    }


  function activateStock(string memory b) public onlyAdmin {
     deactiveStocks[b]=false;
     emit activateStocktransaction(b);
  }

  function deactivateStock(string memory b) public onlyAdmin {
     deactiveStocks[b]=true;
     emit deactivateStocktransaction(b);
  }

  function addStock(string memory a , string memory idStock ) public onlyAdminOrUser {
     stocks[idStock] = a ;
     emit stockAdded(idStock);
     activateStock(idStock) ;
  }

  function getStock (string memory b ) public view returns (string memory , bool ){
      return (stocks[b] , deactiveStocks[b]);
  }

  function updateStock(string memory a , string memory id) public onlyAdminOrUser {
      stocks[id] = a ;
    emit stockUpdated(id);
  }

  
}