pragma solidity >= 0.5.0 < 0.7.0;


import "./IAdministrator.sol";

contract Administrators is IAdministrator  {


  mapping( address => bool) vendors;
  mapping( address => bool) users;
  mapping( address => bool) ngos;
  mapping( address => bool) superAdmins;
  mapping( address => bool) vaccinTeam;


  
  constructor() public {
   superAdmins [msg.sender]=true;
  }

  modifier onlyNgo() {
      require(isNgo(msg.sender), "only admin can do this action");
      _;
  }


  modifier onlySuperAdmin() {
      require(isSuperAdmin(msg.sender), "only super admin can do this action");
      _;
  }


/********** Super Admin ***********/
  function addSuperAdmin(address a ) public  onlySuperAdmin {
    superAdmins[a] = true;
  }

  function isSuperAdmin(address a ) public  view  returns (bool)  {
    return superAdmins[a];
  }

  function removeSuperAdmin(address a ) public  onlySuperAdmin {
    superAdmins[a] = false ;
  }



/********* NGO ************/
    function addNgo (address a ) public  onlySuperAdmin {
    ngos[a] = true;
  }

  function isNgo(address a ) public view override returns (bool) {
    return ngos[a];
  }

  function removeNgo (address a ) public   onlySuperAdmin {
    ngos[a] = false ;
  }



/************ Vendor *************/
  function addVendor(address a ) public  onlyNgo {
    vendors[a] = true;
  }

  function isVendor(address a ) public  view override  returns (bool)  {
    return vendors[a];
  }

  function removeVendor(address a ) public  onlyNgo {
    vendors[a] = false ;
  }



/************* Users *****************/
   function addUser(address a) public  onlyNgo {
    users[a] = true;
  }

  function isUser(address a ) public view  returns (bool) {
    return users[a];
  }

  function removeUser (address a ) public   onlyNgo {
    users[a] = false ;
  }




/***************  vaccinTeam **************/
  function addVaccinTeam(address a) public  onlyNgo {
    vaccinTeam[a] = true;
  }

  function isVaccinTeam(address a ) public view override returns (bool) {
    return vaccinTeam[a];
  }

  function removeVaccinTeam (address a ) public   onlyNgo {
    vaccinTeam[a] = false ;
  }
  
}