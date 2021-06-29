pragma solidity >=0.4.22 <0.9.0;

import "./IAdministrator.sol";


contract Mashing {


    mapping ( string 
    => string) Mashings ; 

    
    address AdministratorAddress;

    
    event mashingAdded(string idMashing);
    event mashingUpdated(string idMashing , string updateMashing);


  constructor(address admin ) public {
  
    AdministratorAddress = admin;
  
  }


  // modifier onlyAdmin() {
  //     require(IAdministrator(AdministratorAddress).isAdmin(msg.sender), "only Admin can do this action");
  //     _;
  // }

  // modifier onlyUser() {
  //     require(IAdministrator(AdministratorAddress).isUser(msg.sender), "only users can do this action");
  //     _;
  // }

    modifier onlyAdminOrUser(){
      require((IAdministrator(AdministratorAddress).isAdmin(msg.sender)||(IAdministrator(AdministratorAddress).isUser(msg.sender)))
      ,"you do not have the right to do this action");
      _;
    }

  function addMashing(string memory a , string memory x) public onlyAdminOrUser {
    Mashings[x] = a ;
    emit mashingAdded(x);
  }

  function getMashing (string memory b ) public view returns (string memory ){
      return Mashings[b];
  }

  function updateMashing(string memory a , string memory id) public onlyAdminOrUser { //a is the object , id is the index
    //Mashings[id] = a ;
    emit mashingUpdated(id , a);
  }

  
}