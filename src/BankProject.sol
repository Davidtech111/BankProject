// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract BankProject1 {
    // Custom Error
    error FeeTooLow(uint256 sentAmount);

    address public immutable bankOwner;
    uint256 public constant FEE = 1 ether;

    uint256 public totalBankBalance;

    struct Account {
        string name;
        uint256 balance;
        address accountAddress;
        bool isActive;
    }

    mapping(address => Account) public accounts;

    // Constructor
    constructor() {
        bankOwner = msg.sender;
    }

    // Modifier
    modifier onlyOwner() {
        require(msg.sender == bankOwner, "Not bank owner");
        _;
    }

    modifier accountExists() {
        require(accounts[msg.sender].isActive, "Account does not exist");
        _;
    }

    // Create Account
    function createAccount(string memory _name) public payable {
        if (msg.value < FEE) {
            revert FeeTooLow(msg.value);
        }

        require(!accounts[msg.sender].isActive, "Account already exists");

        accounts[msg.sender] = Account({
            name: _name,
            balance: 0,
            accountAddress: msg.sender,
            isActive: true
        });
    }

    // Deposit
    function deposit() public payable accountExists {
        require(msg.value > 0, "Amount must be greater than 0");

        accounts[msg.sender].balance += msg.value;
        totalBankBalance += msg.value;
    }

    // Withdraw
    function withdraw(uint256 amount) public accountExists {
        require(accounts[msg.sender].balance >= amount, "Insufficient balance");

        // EFFECT
        accounts[msg.sender].balance -= amount;
        totalBankBalance -= amount;

        // INTERACTION
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
    }

    // Transfer
    function transfer(address _to, uint256 amount) public accountExists {
        require(accounts[msg.sender].balance >= amount, "Insufficient balance");
        require(accounts[_to].isActive, "Recipient does not exist");

        accounts[msg.sender].balance -= amount;
        accounts[_to].balance += amount;
    }

    // View Balance
    function getMyBalance() public view returns (uint256) {
        return accounts[msg.sender].balance;
    }
}