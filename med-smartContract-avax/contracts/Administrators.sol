pragma solidity >= 0.5.0 < 0.7.0;


import "./IAdministrator.sol";

contract Administrators is IAdministrator  {


  mapping( address => bool) doctors;
  mapping( address => bool) admins;
  mapping( address => bool) pharmacists;


  
  constructor() public {
   admins [msg.sender]=true;
  }

  modifier onlyAdmin() {
      require(isAdmin(msg.sender), "only admin can do this action");
      _;
  }

  function addDoctor(address a ) public onlyAdmin{
    doctors[a] = true;
  }

  function isDoctor(address a ) public view returns (bool)  {
    return doctors[a];
  }

  function removeDoctor (address a ) public onlyAdmin{
    doctors[a] = false ;
  }

   function addAdmin(address a) public onlyAdmin {
    admins[a] = true;
  }

  function isAdmin(address a ) public view returns (bool) {
    return admins[a];
  }

  function removeAdmin (address a ) public onlyAdmin{
    admins[a] = false ;
  }

    function addPharmacist (address a ) public onlyAdmin {
    pharmacists[a] = true;
  }

  function isPharmacist (address a ) public view returns (bool) {
    return pharmacists[a];
  }

  function removePharmacist (address a ) public onlyAdmin {
    pharmacists[a] = false ;
  }


  
}