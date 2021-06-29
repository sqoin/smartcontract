pragma solidity >=0.4.22 <0.9.0;


interface IAdministrator {

     function isNgo(address a ) external view returns (bool) ;

     function isVendor (address a ) external view returns (bool) ;

     function isVaccinTeam (address a ) external view returns (bool) ;
}