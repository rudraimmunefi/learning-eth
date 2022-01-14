pragma solidity ^0.6.0;

contract SimpleStorage {
    uint32 public favNumber;

    struct People {
        string name;
        uint32 favNumber;
    }
    People[] public people;

    mapping(string=>uint256) public nameToNumber;

    function saveFaveNum(uint32 _favNumber) public {
        favNumber = _favNumber;
    }

    // When executing a function which makes use of string we need to pass memory to the variable as this needs to be saved at the time of
    // execution but would not be saved permanently. Why? Because string is basically an array.

    function saveStruct(string memory _name, uint32 _favNumber) public {
        people.push(People(_name,_favNumber));
        nameToNumber[_name] = _favNumber;
    }

}
