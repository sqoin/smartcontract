pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import '@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol' ;

import "./IAdministrator.sol";

contract WesharishTokenVaccine is ERC20 , ERC20Burnable {

    address AdministratorAddress;


  event tokenVaccineAdded(address s , uint v);
  event tokenVaccineBurned(address s , uint v);


    constructor (address admin) ERC20("Wesharish","WSC") public {
         AdministratorAddress = admin ;
     } 



     modifier onlyNgo () {
      require(IAdministrator(AdministratorAddress).isNgo(msg.sender),  "only admin can do this action");
      _;
    }

    
     modifier onlyNgoOrVaccinTeam(){
      require((IAdministrator(AdministratorAddress).isNgo(msg.sender)||(IAdministrator(AdministratorAddress).isVaccinTeam(msg.sender)))
      ,"you do not have the right to do this action");
      _;
    }
    




    function mint(address s , uint v) public onlyNgo {
    _mint(s , v);
    emit tokenVaccineAdded(s , v);
    }


    function burnToken( address s , uint v ) public onlyNgoOrVaccinTeam {
     burnFrom(s , v) ;
     emit tokenVaccineBurned(s , v);
    }

}