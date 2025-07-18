// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

contract Lottery {
    address payable[] public players;
    uint256 public usdEntryFee;

    constructor() public {
        usdEntryFee = 2 * 10 ** 18;
    }
    function enter() public payable {
        // require minimum payment. 2$
        players.push(msg.sender);
    }
    function getEntranceFee() public view returns uint256 {}
    function startLottery() public {}

    function endLottery() public {}
}
