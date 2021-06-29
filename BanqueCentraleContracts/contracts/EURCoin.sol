pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import '@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol' ;

contract EURCoin is ERC20 , ERC20Burnable  {

    event tokenEURAdded(address s , uint v);
    event tokenEURBurned(address s , uint v);

     constructor () ERC20("EURCoin","EUR") public {
    

    } 


    function mint(address s , uint v) public  {
    _mint(s , v);
    emit tokenEURAdded(s , v);
    }


    function burnToken( address s , uint v ) public  {
     burnFrom(s , v) ;
     emit tokenEURBurned(s , v);
    }

  
  

}