//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract merkleTesting {
    bytes32 immutable root;
    mapping(address => bool) claimed;

    constructor(bytes32 _root) {
        root = _root; //needed to check if the leaf really belong here
    }

    function verify(bytes32[] calldata _proof, address _addressLookup)
        external
        returns (bool)
    {
        bytes32 _leaf = keccak256(abi.encodePacked(_addressLookup));
        claimed[msg.sender] = true;
        // leaf that would be used to determine if the data is really present in the merkle tree
        require(MerkleProof.verify(_proof, root, _leaf), "error not found");
        return true;
    }
}
