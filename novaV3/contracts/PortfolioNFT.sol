pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


/**
 * @notice - This is the NFT contract for a portfolio
 */
contract PortfolioNFT is ERC721 {


    uint256 public currentPortfolioId;
    
    constructor(
        address owner,  /// Initial owner 
        string memory _Name, 
        string memory _Symbol

    )  public
        ERC721(_Name, _Symbol) 
    {
        mint(owner);
    }

    /** 
     * @dev mint a portfolio
     */
    function mint(address to) public returns (bool) {
        /// Mint a new Portfolio
        uint256 newPortfolioId = getNextPortfolioId();
        currentPortfolioId++;
        _mint(to, newPortfolioId);
        return true ;

    }


    ///--------------------------------------
    /// Getter methods
    ///--------------------------------------


    ///--------------------------------------
    /// Private methods
    ///--------------------------------------
    function getNextPortfolioId() private view returns (uint256 ) {
        return currentPortfolioId+1;
    }

}
