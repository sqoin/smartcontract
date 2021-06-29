pragma solidity >=0.4.22 <0.9.0;


interface IAdministrator {

    function isDoctor(address a ) external view returns (bool) ;

    function isPharmacist (address a ) external view returns (bool) ;
}