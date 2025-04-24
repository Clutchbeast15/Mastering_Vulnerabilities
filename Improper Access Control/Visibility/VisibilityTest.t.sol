//SPD-Licence-Identifier: MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {ownerGame} from "../src/Visibility.sol";
import {console} from "forge-std/console.sol";

contract VisibilityTest is Test{
        ownerGame public game;
        address public Attcker = address(0x123);


        function setUp() public {
                game = new ownerGame();
        }

        function testChangeOwner() public {
         console.log("Owner before change: ", game.owner());

         game.changeOwner(Attcker);
         
         console.log("Owner after change: ", game.owner());
         assertEq(game.owner(), Attcker);

        }
}
