pragma solidity >=0.4.22 <0.9.0;


interface IAdministrator {

    function isAdmin(address a ) external view returns (bool) ;

    function isUser (address a ) external view returns (bool) ;
}