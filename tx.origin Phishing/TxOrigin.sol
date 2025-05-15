//SPDX-License-Identifier:
pragma solidity ^0.8.15;

contract Wallet {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    function transfer(address payable _to, uint256 _amount) public {
        // check with msg.sender instead of tx.origin
        require(tx.origin == owner, "Not owner");

        (bool sent,) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }
}
