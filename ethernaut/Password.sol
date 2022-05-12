// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract pwn {

    bytes32 password = 0x3058e6e6e48ad7d84ce190dca0651c119bb5c44d4c0432a59df81d787b8ecd16;

    function decode() public view returns (bytes16) {
        return (bytes16(password));
    }
    
}
