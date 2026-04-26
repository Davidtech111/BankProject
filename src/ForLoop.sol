// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ForLoop {
    
    struct Account {
        string name;
        uint256 balance;
        address accountAddress;
        bool isActive;
    }

    // Dynamic array
    Account[] public accounts;

    // Add multiple accounts using for loop
    function addMultipleAccounts(
        string[] memory names,
        address[] memory addresses
    ) public {

        require(names.length == addresses.length, "Array mismatch");

        for (uint256 i = 0; i < names.length; i++) {

            accounts.push(Account({
                name: names[i],
                balance: 0,
                accountAddress: addresses[i],
                isActive: true
            }));
        }
    }

    // Get total accounts
    function getTotalAccounts() public view returns (uint256) {
        return accounts.length;
    }
}