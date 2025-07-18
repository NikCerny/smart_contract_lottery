// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract Lottery {
    address payable[] public players;
    uint256 public usdEntryFee;
    AggregatorV3Interface internal ethUsdPriceFeed;
    mapping(address => uint256) public addressToAmountFunded;

    constructor(address _priceFeedAddress) public {
        usdEntryFee = 2 * 10 ** 18;
        ethUsdPriceFeed = AggregatorV3Interface(_priceFeedAddress);
    }
    function enter() public payable {
        uint256 minimumUSD = 2 * 10 ** 18; // 2 USD
        require(
            getConversionRate(msg.value) >= minimumUSD,
            "You need to spend more USD"
        );
        addressToAmountFunded[msg.sender] += msg.value;
        players.push(msg.sender);
    }
    function getPrice() public view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer * 10 ** (18 - 8)); // 8 is the decimals of the price feed in chainlink ETH/USD
    }

    function getEntranceFee() public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 precision = 1 * 10 ** 18;
        uint256 costToEnter = (usdEntryFee * precision) / ethPrice;
        return costToEnter;
    }
    function startLottery() public {}

    function endLottery() public {}
}
