pragma solidity ^0.5.11;


contract ReceiveMoney {
    
    uint public balanceReceived;
    
    function Receive() public payable {
        balanceReceived += msg.value;
    }
    
    function checkbalance() public view returns(uint){
        return address(this).balance;
    }
    
    function sendMoney() public{
        address payable to = msg.sender;
        to.transfer(this.checkbalance());
    }
    
    function sendtocustomeraddress(address payable _to) public {
        _to.transfer(this.checkbalance());
    }
}
