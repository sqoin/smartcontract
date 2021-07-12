pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;



contract PortfolioManagement1 {

 struct Portfolio {
    uint portfolioId;
    string name ;
    string description;
    string creatorName ;
    string twitterLink ;
    string redditLink ;
    string tradingviewLink ;
 }

 Portfolio [] portfolios ;


event portfolioAdded(uint portfolioId);


  constructor() public {
  
  }

function createPortfolio (string memory _name , string memory _description, string memory _creatorName  , string memory  twitterLink , string memory redditLink , string memory tradingviewLink) public returns (uint) {
    // portfolios[portfolios.length].name = _name;
    // portfolios[portfolios.length].description = _description;
    // portfolios[portfolios.length].portfolioId = portfolios.length;
    Portfolio memory portfolio = Portfolio(portfolios.length, _name , _description , _creatorName, twitterLink , redditLink ,tradingviewLink); 
    portfolios.push(portfolio);
    emit portfolioAdded (portfolios.length-1);
    return (portfolios.length-1) ;

}

function assignCreatorToPortfolio (uint _portfolioId , string memory _creatorName , string memory _twitterLink , string memory _redditLink , string memory _tradingviewLink ) public 
  {
      portfolios[_portfolioId].creatorName = _creatorName;
      portfolios[_portfolioId].twitterLink = _twitterLink;
      portfolios[_portfolioId].redditLink = _redditLink;
      portfolios[_portfolioId].tradingviewLink = _tradingviewLink;
  }
 
 function getPortfoliosLength() public view returns (uint) {
    return portfolios.length-1;
  }

  // function getPortfolioDetails(uint index) public view returns (uint , string memory ,  string memory  ,  string memory ,  string memory,  string memory, string memory){

  //   return (portfolios[index].portfolioId, portfolios[index].name, portfolios[index].description,
  //    portfolios[index].creatorName ,  portfolios[index].twitterLink,  portfolios[index].redditLink, portfolios[index].tradingviewLink);

  // }


   function getPortfolioDetails(uint index) public view returns (Portfolio memory _portfolios){

      Portfolio memory portfolio = portfolios[index];
      return portfolio;
   }

  function getAllPortfolios () public view returns (Portfolio [] memory _portfolios)
    {
      return portfolios;
    }


  
}