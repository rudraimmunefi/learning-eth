pragma solidity ^0.5.11;

contract MyContract {
    uint256 public myInt; 
    
    function myInt( uint256 _myInt) public{
        myInt = _myInt;
    }
}
