pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import '@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol' ;


contract DTCoin is ERC20 , ERC20Burnable  {


    event tokenDTCAdded(address s , uint v);
    event tokenDTCBurned(address s , uint v);

    constructor () ERC20("DTCoin","DTC") public {
      
     } 



    function mint(address s , uint v) public  {
    _mint(s , v);
    emit tokenDTCAdded(s , v);
    }


    function burnToken( address s , uint v ) public  {
     burnFrom(s , v) ;
     emit tokenDTCBurned(s , v);
    }

}