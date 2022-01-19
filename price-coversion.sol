// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Chain {

    mapping(address => uint256) public balance;
    uint256 public minimumDeposit1 = 50*10**10;

    function receiveMoney() payable public {
        uint256 minBalance = 50 * 10 ** 18;
        require(getConversionRate(msg.value) >= minBalance,"Please deposit more USD!");
        balance[msg.sender] += msg.value;
    }

    function getVersion() public view returns(uint256){
        /* how do we call external contracts? we initalize a varible with the type, and then call the function.
        */
        AggregatorV3Interface getVer = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        return getVer.version();
    }

    function getPricefeed() public view returns (uint256){
        AggregatorV3Interface getVer = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        (,int256 answer,,,) = getVer.latestRoundData();
        // why we did 10000000000 because price returns 306216329944 which is 3062$ and rest is 8 chars so we make it in wei format
        return uint256(answer*10000000000);
    }

    function getConversionRate(uint256 _ethamount) public view returns (uint256){
        uint256 ethprice = getPricefeed();
        uint256 priceInUSD = (ethprice * _ethamount) / 1000000000000000000;
        return priceInUSD;
    }

    function withDraw() payable public {
        payable(msg.sender).transfer(address(this).balance);
    }
}
