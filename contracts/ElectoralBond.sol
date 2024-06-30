// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ElectoralBond {

    struct User {
        string name;
        bool isRegistered;
    }

    mapping(address => User) private users;
    mapping (string => address) private s_partyToWalletMap;
    mapping(address => uint) private userBalances;

    modifier onlyRegisteredUser() {
        require(users[msg.sender].isRegistered, "User not registered");
        _;
    }

    function registerUser(string memory name) public {
        require(!users[msg.sender].isRegistered, "User already registered");
        users[msg.sender] = User(name, true);
    }

    function purchaseBond() public payable onlyRegisteredUser {
        require(msg.value > 0, "You need to send some Ether");
        userBalances[msg.sender] += msg.value;
    }

    function transferBond(string memory partyName, uint amount) public onlyRegisteredUser {
        address to = s_partyToWalletMap[partyName];
        require(to != address(0), "Party not registered");
        require(userBalances[msg.sender] >= amount, "Insufficient balance");

        userBalances[msg.sender] -= amount;
        payable(to).transfer(amount);
    }

    function mapAddress (string memory partyName, address waletAddress) public {
        s_partyToWalletMap[partyName] = waletAddress;
    }

    function changeWalletAddress (string memory partyName, address changedWalletAddress) public {
        s_partyToWalletMap[partyName] = changedWalletAddress;
    }

    function getWalletAddress(string memory partyName) public view returns (address) {
        return s_partyToWalletMap[partyName];
    }

}