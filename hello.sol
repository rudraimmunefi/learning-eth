pragma solidity ^0.4.17; //version of solidity used
//contract is a keyword , is kind of identical to classes
contract Inbox {
    
    string public message; //instance variable, gonna remain for the life of contract
    // public is a keyword to define who has access to it
    
    function Inbox(string initialMessage) public {
        message = initialMessage;
    }
    
    function setMessage(string newMessage) public {
        message = newMessage;
    }

    function getMessage() public view returns (string) {
        return message;
    }
    
}
