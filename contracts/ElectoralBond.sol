// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ElectoralBond {
    mapping(string => address) private s_partyToWalletMap;
    mapping(string => uint) private s_partyBalances;
    mapping(address => string[]) private s_partyRemarks;
    
    // Mapping to keep track of individual user contributions to a party
    mapping(string => mapping(address => uint)) private userContributions;
    
    event RemarkLeft(address indexed partyAddress, string partyName, string remark, address indexed userAddress);

    function transferBond(string memory partyName, uint amount) public payable {
        address to = s_partyToWalletMap[partyName];
        require(to != address(0), "Party not registered");
        require(msg.value >= amount && amount > 0, "Insufficient or zero Ether sent");

        s_partyBalances[partyName] += amount;
        userContributions[partyName][msg.sender] += amount; // Track contribution per user
        payable(to).transfer(amount);
    }

    function useFunds(string memory partyName, uint amount, string memory remark, address userAddress) public {
        address partyAddress = s_partyToWalletMap[partyName];
        require(msg.sender == partyAddress, "Only the registered party can use these funds");
        require(userContributions[partyName][userAddress] >= amount, "Insufficient balance from this user");

        s_partyBalances[partyName] -= amount;
        userContributions[partyName][userAddress] -= amount; // Deduct the used amount from the user's contribution
        s_partyRemarks[partyAddress].push(remark);

        emit RemarkLeft(partyAddress, partyName, remark, userAddress);
    }

    function getWalletAddress(string memory partyName) public view returns (address) {
        return s_partyToWalletMap[partyName];
    }

    function getPartyBalance(string memory partyName) public view returns (uint) {
        return s_partyBalances[partyName];
    }

    function getUserContribution(string memory partyName, address user) public view returns (uint) {
        return userContributions[partyName][user];
    }
}
