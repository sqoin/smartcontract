// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;

contract ValidatedTokenEuro is ERC20 {
  
  address validator;
  address coin;
   constructor(address v , address c)  ERC20("ValidatedTokenEuro","vEURO") public{
    validator = v;
    coin = c;
  }

  function validate(address a) public  {
    require(msg.sender == validator);
    uint b = balanceOf(a);
    _burn(a , balanceOf(a));
    (IERC20)(coin).transfer(a , b);
  }  

  function reject(address a) public  {
    require(msg.sender == validator);
   // uint b = balanceOf(a);
    _burn(a , balanceOf(a));
  } 
}