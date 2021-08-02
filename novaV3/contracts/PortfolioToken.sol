pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import '@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol' ;
import './Interface/IUniSwap.sol';
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
//import "@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";




contract PortfolioToken is ERC20 , ERC20Burnable 

{
  using SafeMath for uint256;


    address owner;


    address  uniswapAdress ;
    address[] public pair;
    address[] public pairInverse;

    struct listFundsByToken {
        address user ; 
        uint256 amount;
    }

    struct Asset {
        address assetAddress;
        uint256 assetValue;
    }

    struct Strategy{
        address strategyAddress;
        uint256 yield;
    }
   
  

    event depositStrategy( uint256 amountIn ,address to , uint value , address tokenDeposit , address tokenToSwap);
    event tokennWBTCWithDraw(  uint256 amountIn , address senderAddress , uint256 usdc , uint256 wbtc);
    event yieldStrategy (uint256  amount , address sender, address strategy);

    
    mapping (address => listFundsByToken[]) listFunds;



    Asset[] pourcentageAssets;
    Strategy[] yieldStrategies;



    constructor ( address _owner,  
        string memory _Name, 
        string memory _Symbol,
        address[] memory  _assetsNames,
        uint[] memory _assetsValues,
        address[] memory _strategy ,
        uint[] memory _yield
 )  ERC20(_Name, _Symbol) public {

        owner = _owner;

        fillPourcentageAssets (_assetsNames ,_assetsValues );
        fillYieldStrategies (_strategy , _yield ) ;


    } 

    function fillPourcentageAssets(address[] memory  _assetsNames,uint[] memory _assetsValues)  private {

        for (uint i = 0; i < _assetsNames.length; i++) {
            Asset memory asset = Asset ({
                assetAddress : _assetsNames[i] ,
                assetValue : _assetsValues[i] 
            });
            pourcentageAssets.push(asset); 
        }
    }


    function fillYieldStrategies (address[] memory _strategy , uint[] memory _yield) private {

        for (uint i = 0; i < _strategy.length; i++) {
             Strategy memory strategy = Strategy ({
                strategyAddress : _strategy[i] ,
                yield : _yield[i] 
            });
            yieldStrategies.push(strategy);
        }
    }


    function deposit (uint amountIn ,address tokenDeposit ) public {

        //send amount to deposit from sender to smart contracts
        IERC20(tokenDeposit).transferFrom(msg.sender,address(this) ,amountIn);
        _mint(msg.sender , amountIn);

        address tokenToSwap ;
        uint pourcentage ; 

        //loop to swap to each assets with her poucentage
        for (uint i=0 ; i < pourcentageAssets.length ; i++)
        {
            tokenToSwap = pourcentageAssets[i].assetAddress ;
            pourcentage = pourcentageAssets[i].assetValue ;
            pair = [ tokenDeposit ,tokenToSwap ];
            // get balance of asset token to swap before swap 
            uint256 OldbalanceTokenToSwap = IERC20(tokenToSwap).balanceOf(address(this));
            uint256 value = amountIn.mul(pourcentage).div(100);
            IERC20(tokenDeposit).approve(uniswapAdress , value);
            IUniSwap(uniswapAdress).swapExactTokensForTokens(value, 0,pair  , address(this), 10000000000000000) ;
            
            // get balance of token to swap after swap
            uint256 NewBalanceTokenToSwap = IERC20(tokenToSwap).balanceOf(address(this));
            // save the difference between new balance and old balance 
            uint256 diffBalance = NewBalanceTokenToSwap - OldbalanceTokenToSwap ;

            // update the funds saved 
            for (uint j=0 ; j < listFunds[tokenDeposit].length ; j++){
                // save the funds of tokenSwapped of sender after subtraction 
                if(listFunds[tokenDeposit][j].user == msg.sender ){
                     uint256 oldBalanceSenderTokenDeposit =  listFunds[tokenDeposit][j].amount;
                     listFunds[tokenDeposit][j].amount = oldBalanceSenderTokenDeposit.sub(value);
                    }
                //save the funds of token to swap of sender after yield
                if(listFunds[tokenToSwap][j].user == msg.sender ){
                     uint256 oldBalanceSenderTokenToSwap = listFunds[tokenToSwap][j].amount;

                     // yield strategy : send the amount swapped from smart contract to address of the strategy
                      uint256 fundsRest = diffBalance ;
                     for ( uint k=0 ; k < yieldStrategies.length ; k++ )
                     {
                        uint256 yieldValue = diffBalance.mul(yieldStrategies[k].yield).div(100);
                        IERC20(tokenToSwap).transferFrom(address(this), yieldStrategies[k].strategyAddress ,yieldValue);
                        fundsRest -= yieldValue ;
                        emit yieldStrategy ( yieldValue , msg.sender ,yieldStrategies[k].strategyAddress ) ;
                     }

                     // send 10%  to the owner of the strategy
                     if (msg.sender != owner){
                          uint256 yieldValue = diffBalance.mul(10).div(100);
                        IERC20(tokenToSwap).transferFrom(address(this), owner ,yieldValue);
                        fundsRest -= yieldValue ;
                        emit yieldStrategy ( yieldValue , msg.sender ,owner ) ;
                     }

                     listFunds[tokenToSwap][j].amount = oldBalanceSenderTokenToSwap.add(fundsRest);
                    }
                }
            emit depositStrategy(amountIn ,msg.sender , value , tokenDeposit , tokenToSwap );
        }      
    }




    



}
