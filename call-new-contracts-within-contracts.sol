pragma solidity ^0.6.0;

import "./youtube.sol";

contract simpleStorage{
    SimpleStorage[] public add;

    function deploy() public {
        SimpleStorage store = new SimpleStorage();
        add.push(store);
    }
    
    function saveFav(uint32 _fNum, uint32 _contractIndex) public {
        /* to run a function from some other contract we need it's address to be passed in the contract object and then calling the function.
        */
        SimpleStorage(address(add[_contractIndex])).saveFaveNum(_fNum);
    }
    
    function viewFav(uint32 _contractIndex) public view returns(uint256) {
        return SimpleStorage(address(add[_contractIndex])).viewData();
    }
}
