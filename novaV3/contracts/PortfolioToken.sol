pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import '@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol' ;
import './Interface/IUniSwap.sol';
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import "@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";




contract PortfolioToken is ERC20 , ERC20Burnable , ERC20Pausable {
  using SafeMath for uint256;


    address owner;


    address  wbtcAddress;
    address  usdcAddress ;
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
   
  
    event tokennWBTCAdded( uint amountIn ,address to , uint volatility , uint256 usdcAmount , uint256 wbtcAmount ,address wbtcAddress , address usdcAddress);
    event tokennWBTCWithDraw(  uint amountIn , address senderAddress , uint256 usdc , uint256 wbtc);

    
    mapping (address => listFundsByToken[]) listFunds;



    Asset[] pourcentageAssets;
    Strategy[] yieldStrategies;

////////////////
    mapping (address => uint256) private _usdcbalances;
    mapping (address => uint256) private _wbtcbalances;
///////////////

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


/////////////////
        wbtcAddress = wbtcAds;
        uniswapAdress = uniswapAds ; 
        usdcAddress = addressContractUsdc ;
        pair = [wbtcAddress , usdcAddress] ; 
        pairInverse = [ usdcAddress , wbtcAddress] ; 
        ///////////////////


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

            pourcentageAssets.push(strategy);

        }
    }


    function deposit (uint amountIn ,address tokenDeposit ) public {

        IERC20(tokenDeposit).transferFrom(msg.sender,address(this) ,amountIn);
         _mint(msg.sender , amountIn);
       address tokenToSwap ;
       uint pourcentage ; 
        for (uint i ; i < pourcentageAssets ; i++)
        {
            tokenToSwap = pourcentageAssets[i].assetAddress ;
            pourcentage = pourcentageAssets[i].assetAddress ;
            pair = [ tokenDeposit ,tokenToSwap ];
            // get balance of asset token to swap before swap 
            uint256 OldbalanceTokenToSwap = IERC20(tokenToSwap).balanceOf(address(this));
            uint256 value = amountIn.mul(pourcentage).div(100);
            IERC20(tokenDeposit).approve(uniswapAdress , value);
            IUniSwap(uniswapAdress).swapExactTokensForTokens(value, 0,pair  , address(this), 10000000000000000) ;
            uint256 NewBalanceTokenToSwap = IERC20(tokenToSwap).balanceOf(address(this));
        
            // get balance of token to swap after swap
            uint256 diffBalance = NewBalanceTokenToSwap - OldbalanceTokenToSwap ;

            // save the difference in _usdcbalances and _wbtcbalances
            for (uint i ; i < pourcentageAssets ; i++){
                if(listFunds[tokenDeposit][i].user == msg.sender ){
                     uint256 oldBalanceSenderTokenDeposit =  listFunds[tokenDeposit][i].amount;
                     listFunds[tokenDeposit][i].amount = oldBalanceSenderTokenDeposit.sub(value);
                    }
                if(listFunds[tokenToSwap][i].user == msg.sender ){
                     uint256 oldBalanceSenderTokenToSwap =  listFunds[tokenToSwap][i].amount;
                     listFunds[tokenToSwap][i].amount = oldBalanceSenderTokenToSwap.add(diffBalance);
                    }
                }
  
        
            emit tokennWBTCAdded(  amountIn ,msg.sender , value , tokenDeposit , tokenToSwap ,wbtcAddress , usdcAddress  );
        }
            
    }

    



}
