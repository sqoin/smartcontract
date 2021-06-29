pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import '@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol' ;

import "./IAdministrator.sol";

contract WesharishTokenDonation is ERC20 , ERC20Burnable {

     address AdministratorAddress;

     event tokenDonationAdded(address s , uint v);
     event tokenDonationBurned(address s , uint v);

     constructor (address admin) ERC20("Wesharish","WSC") public {
       AdministratorAddress = admin ;

    } 



    modifier onlyNgo() {
      require(IAdministrator(AdministratorAddress).isNgo(msg.sender), "only admin can do this action");
      _;
    }

    modifier onlyVendor() {
      require(IAdministrator(AdministratorAddress).isVendor(msg.sender), "only vendor can do this action");
      _;
    }

    modifier onlyNgoOrVendor(){
      require((IAdministrator(AdministratorAddress).isNgo(msg.sender)||(IAdministrator(AdministratorAddress).isVendor(msg.sender))),"you do not have the right to do this action");
      _;
    }



    function mint(address s , uint v) public onlyNgo {
    _mint(s , v);
    emit tokenDonationAdded(s,v);

    }


    function burnToken( address s , uint v ) public onlyNgoOrVendor {
    burnFrom(s , v) ;
    emit tokenDonationBurned(s , v);
    }

  

}