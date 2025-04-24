//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ownerGame {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // visibility of changeOwner function should be onlyOwner
    function changeOwner(address _new) public {
        owner = _new;
    }
}
