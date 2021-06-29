pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import '@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol' ;


contract coinTest is ERC20 , ERC20Burnable  {

  
    event tokenCoinTestAdded(address s , uint v);
    event tokenCoinTestBurned(address s , uint v);

    constructor () ERC20("coinTest","coinTest") public {
      
     } 


    function mint(address s , uint v) public  {
    _mint(s , v);
    emit tokenCoinTestAdded(s , v);
    }


    function burnToken( address s , uint v ) public  {
     burnFrom(s , v) ;
     emit tokenCoinTestBurned(s , v);
    }


}