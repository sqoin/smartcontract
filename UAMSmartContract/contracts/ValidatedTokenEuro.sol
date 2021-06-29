// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;

contract ValidatedTokenEuro is ERC20 {
  
  address validator;
  address coin;
  address sender;

  

   constructor(address v , address c , address s)  ERC20("ValidatedTokenEuro","vEURO") public{
    validator = v;
    coin = c;
    sender = s;
  }

  function mint(address a , uint amount) public {
    //(IERC20)(coin).transferFrom( msg.sender, (address)(this), amount);
   // transferFrom( msg.sender, (address)(this), amount);
    _mint(a , amount);
  } 

  function validate(address a , uint  amount) public  {
    require(msg.sender == validator);
    _burn(a , amount);
    (IERC20)(coin).transfer(a , amount);
  }  

  function reject(address a) public  {
    require(msg.sender == validator);
    uint b = balanceOf(a);
    (IERC20)(coin).transfer( /* */ sender , b);
    _burn(a , balanceOf(a));
  } 
}