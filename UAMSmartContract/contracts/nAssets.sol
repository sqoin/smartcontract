// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import '@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol' ;


 contract nAssets is ERC20 , ERC20Burnable  {
  using SafeMath for uint256;
    address  wbtcAddress;


    event tokennDeposit(  uint amountIn , address senderAddress );
    event tokennWithDraw(  uint amountIn , address senderAddress );
    event tokenTransfer(  uint amount , address senderAddress , address receiptAddress );

    constructor ()  ERC20("nAssets","n") public {
 
    }

     function deposit (uint amountIn ) public {
         emit tokennDeposit(amountIn,msg.sender);
     }


     function transferToken (address receipt ,   uint amount) public {
         emit tokenTransfer(amount, msg.sender , receipt);
     }

      function withdraw (uint amountIn ) public {
         emit tokennWithDraw(amountIn, msg.sender);
     }

     

}