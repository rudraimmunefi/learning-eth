pragma solidity ^0.5.11;


contract ReceiveMoney {
    
    bool public paused;
    address public owner;
    int public amount;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function Receive() public payable {
        amount = int(address(this).balance);
    }
    
    function destroy(address payable _to) public{
        require(owner == msg.sender,"Not Authorized!!!!");
        selfdestruct(_to);
    }
    
    function pause(bool _paused) public {
        require(owner == msg.sender, "You are not owner");
        require(!paused,"Contract is paused");
        paused = _paused;
    }
    
    function withdrawall(address payable _to) public {
        require(owner == msg.sender,"You are not owner");
        require(!paused,"Contract is paused!!");
        _to.transfer(address(this).balance);
    }
}
