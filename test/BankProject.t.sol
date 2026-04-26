// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "forge-std/Test.sol";
import "../src/BankProject1.sol";

contract BankProjectTest is Test {
    BankProject1 bank;

    address user = address(1);

    function setUp() public {
        bank = new BankProject1();
    }

    function testCreateAccount() public {
        vm.deal(user, 2 ether);

        vm.prank(user);
        bank.createAccount{value: 1 ether}("David");

        uint256 balance = bank.getMyBalance();
        assertEq(balance, 0);
    }

    function testDeposit() public {
        vm.deal(user, 3 ether);

        vm.prank(user);
        bank.createAccount{value: 1 ether}("David");

        vm.prank(user);
        bank.deposit{value: 1 ether}();

        uint256 balance = bank.getMyBalance();
        assertEq(balance, 1 ether);
    }

    function testWithdraw() public {
        vm.deal(user, 5 ether);

        vm.startPrank(user);
        bank.createAccount{value: 1 ether}("David");
        bank.deposit{value: 2 ether}();
        bank.withdraw(1 ether);
        vm.stopPrank();

        uint256 balance = bank.getMyBalance();
        assertEq(balance, 1 ether);
    }
}