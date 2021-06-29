pragma solidity >= 0.5.0 < 0.7.0;

import "./IAdministrator.sol";

contract Administrators is IAdministrator{


  mapping( address => bool ) users;
  mapping( address => string) usersList;
  
  mapping( address => bool) admins;
  mapping( address => string) adminsList;


event addedAdmin(address addresse , string name);
event addedUser(address addresse , string name);
event removedAdmin(address addresse , string name);
event removedUser(address addresse , string name);

  
  constructor() public {
   admins [msg.sender]=true;
   adminsList[msg.sender]="Jawaher";
  }

  modifier onlyAdmin() {
      require(isAdmin(msg.sender), "only Admin can do this action");
      _;
  }


function isRegistred(address a ) public view returns (bool) {
  return isAdmin(a) || isUser(a);
}

   function addAdmin(address a , string memory name) public onlyAdmin {
    admins[a] = true;
    adminsList[a] = name;
    emit addedAdmin(a , name );
  }

  function isAdmin(address a ) public view returns (bool) {
    return (admins[a]);
  }
  function getInfoAdmin(address a ) public view returns (bool , string memory) {
    return (admins[a] , adminsList[a]);
  }

  function removeAdmin (address a ) public onlyAdmin{
    admins[a] = false ;
    adminsList[a] = "deleted" ;
    emit removedAdmin(a , adminsList[a] );
  }



  function addUser(address a ,string memory name  ) public onlyAdmin{
    users[a] = true;
    usersList[a] = name;
     emit addedUser(a , name );
  }

  function isUser(address a ) public view returns (bool)  {
    return (users[a]);
  }

    function getInfoUser(address a ) public view returns (bool , string memory)  {
    return (users[a], adminsList[a]);
  }

  function removeUser (address a ) public onlyAdmin{
    users[a] = false ;
    usersList[a] = "deleted" ;
     emit removedUser(a , adminsList[a] );
  }


  
}