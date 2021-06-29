pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import '@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol' ;


contract USDCoin is ERC20 , ERC20Burnable  {

  
    event tokenUSDAdded(address s , uint v);
    event tokenUSDBurned(address s , uint v);

    constructor () ERC20("USDCoin","USD") public {
      
     } 


    function mint(address s , uint v) public  {
    _mint(s , v);
    emit tokenUSDAdded(s , v);
    }


    function burnToken( address s , uint v ) public  {
     burnFrom(s , v) ;
     emit tokenUSDBurned(s , v);
    }

    




}