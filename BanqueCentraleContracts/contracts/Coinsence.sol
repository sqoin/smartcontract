pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import '@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol' ;


contract Coinsence is ERC20 , ERC20Burnable  {

  
    event tokenCoinsenceAdded(address s , uint v);
    event tokenCoinsenceBurned(address s , uint v);

    constructor () ERC20("Coinsence","Coinsence") public {
      
     } 


    function mint(address s , uint v) public  {
    _mint(s , v);
    emit tokenCoinsenceAdded(s , v);
    }


    function burnToken( address s , uint v ) public  {
     burnFrom(s , v) ;
     emit tokenCoinsenceBurned(s , v);
    }


}