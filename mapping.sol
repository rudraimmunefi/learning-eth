pragma solidity ^0.5.11;


contract ReceiveMoney {
    
   mapping(address => bool) public myMapping;
   
   function setaddrestoTrue() public{
       myMapping[msg.sender] = true;
   }
}
