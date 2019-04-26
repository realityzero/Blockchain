//Version of Compiler
pragma solidity ^0.4.11;

contract coins_ico{
    
    //Introducing maximum number of coins available for sale
    uint public max_coins = 1000000;
    
    //Introducing USD to Coins conversion rate
    uint public usd_to_coins = 1000;
    
    //Introducing the total number of Coins bought by the investors
    uint public total_coins_bought = 0;
    
    //Mapping from the investor address to its equity in Coins and USD
    mapping(address => uint) equity_coins;
    mapping(address => uint) equity_usd;
    
    //Checking if an investor can buy Coins
    modifier can_buy_coins(uint usd_invested) {
        require(usd_invested * usd_invested + total_coins_bought <= max_coins);
        _;
    }
    
    //Getting the equity in coins of an investor
    function equity_in_coins(address investor) external constant returns (uint){
        return equity_coins[investor];
    }
    
    //Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }
    
    //Buy Coins
    function buy_coins(address investor, uint usd_invested) external
    can_buy_coins(usd_invested) {
        uint coins_bought = usd_invested * usd_to_coins;
        equity_coins[investor] += coins_bought;
        equity_usd[investor] = equity_coins[investor] / usd_to_coins;
        total_coins_bought += coins_bought;
    }
    
    //Selling Coins
    function sell_coins(address investor, uint coins_sold) external {
        equity_coins[investor] -= coins_sold;
        equity_usd[investor] = equity_coins[investor] / usd_to_coins;
        total_coins_bought -= coins_sold;
    }
}
