pragma solidity ^0.5.11;


contract MappingExample {
    
    mapping(address => uint) public BalanceReceived;
    address payable public owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
   function getBalance() public view returns(uint){
       return address(this).balance;
   }
   
   function sendMoney() public payable {
       BalanceReceived[msg.sender] = msg.value;
   }
   
   function withdrawAll() public payable{
       require(msg.sender == owner,"You are not authorized!!");
       owner.transfer(address(this).balance);
   }
   
   function sendAmount(address payable _addresss,uint _amount) public{
       require(BalanceReceived[_addresss] >= _amount,"Not Enough Balance");
       BalanceReceived[_addresss] -= _amount;
       _addresss.transfer(_amount);
   }
}
