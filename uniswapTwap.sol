//SPDX-License-Identifier: MIT
pragma solidity 0.6.6;

import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "@uniswap/lib/contracts/libraries/FixedPoint.sol";
import "@uniswap/v2-periphery/contracts/libraries/UniswapV2OracleLibrary.sol";
import "@uniswap/v2-periphery/contracts/libraries/UniswapV2Library.sol";

contract uniSwapv2Twap {
    // Formula for TWAP is priceCumulative2 - priceCumulative1 / timestamp2 - timestamp1

    using FixedPoint for *;
    uint256 public constant PERIOD = 10; // period in which the TWAP will be updated
    IUniswapV2Pair public immutable pair; // Pair Address

    address public immutable token0; //token pair addresses
    address public immutable token1;

    uint256 public price0CumulativeLast; // the difference in price
    uint256 public price1CumulativeLast;

    uint32 public blockTimeStampLast;

    FixedPoint.uq112x112 public price0Average;
    FixedPoint.uq112x112 public price1Average; // the first 112bits holds the decimal points and the next hold the whole number

    constructor(
        address _factory,
        address _tokenA,
        address _tokenB
    ) public {
        IUniswapV2Pair _pair = IUniswapV2Pair(
            UniswapV2Library.pairFor(_factory, _tokenA, _tokenB)
        );
        pair = _pair;
        token0 = _pair.token0();
        token1 = _pair.token1();
        price0CumulativeLast = _pair.price0CumulativeLast(); // fetch the current accumulated price value (1 / 0)
        price1CumulativeLast = _pair.price1CumulativeLast(); // fetch the current accumulated price value (0 / 1)
        (, , blockTimeStampLast) = _pair.getReserves();
    }

    function update() external {
        (
            uint256 price0Cumulative,
            uint256 price1Cumulative,
            uint32 blockTimestamp
        ) = UniswapV2OracleLibrary.currentCumulativePrices(address(pair));
        uint256 timeElapsed = blockTimestamp - blockTimeStampLast;
        require(timeElapsed >= PERIOD, "Time not elapsed");
        //running the TWAP formula
        price0Average = FixedPoint.uq112x112(
            uint224((price0Cumulative - price0CumulativeLast) / timeElapsed)
        );
        price1Average = FixedPoint.uq112x112(
            uint224((price1Cumulative - price1CumulativeLast) / timeElapsed)
        );

        // updating state variable to update in next request

        price0CumulativeLast = price0Cumulative;
        price1CumulativeLast = price1Cumulative;
        blockTimeStampLast = blockTimestamp;
    }

    function consult(address token, uint256 amountIn)
        external
        view
        returns (uint256 amountOut)
    {
        require(token == token0 || token == token1, "invalid argument");
        if (token == token0) {
            amountOut = price0Average.mul(amountIn).decode144();
        } else {
            amountOut = price1Average.mul(amountIn).decode144();
        }
    }
}
