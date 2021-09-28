pragma solidity ^0.5.11;

contract MyContract {
    uint256 public myInt;
    
    function myuInt( uint256 _myInt) public{
        myInt = _myInt;
    }
    
    bool public mybool;
    
    function myBool( bool _myBool) public {
        mybool = _myBool;
    }
    
    uint8 public u8;
    
    function increment() public {
        u8++;
    }
    
    function decrement() public {
        u8--;
    }
    
    address public _add;
    
    function setaddress(address _setaddress) public{
        _add = _setaddress;
    }
    
    function fetchbal() public view returns(uint) {
        return _add.balance;
    }
   
   
   
 }
