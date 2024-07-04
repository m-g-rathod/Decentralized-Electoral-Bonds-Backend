// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ElectoralBond {
    mapping (string => address) private s_partyToWalletMap;
    mapping (string => uint) private s_partyBalances;

    function transferBond(string memory partyName, uint amount) public payable {
        address to = s_partyToWalletMap[partyName];
        require(to != address(0), "Party not registered");
        require(msg.value >= amount && amount > 0, "Insufficient or zero Ether sent");

        s_partyBalances[partyName] += amount;
        payable(to).transfer(amount);
    }

    function mapAddress (string memory partyName, address walletAddress) public {
        s_partyToWalletMap[partyName] = walletAddress;
    }

    function changeWalletAddress (string memory partyName, address changedWalletAddress) public {
        s_partyToWalletMap[partyName] = changedWalletAddress;
    }

    function getWalletAddress(string memory partyName) public view returns (address) {
        return s_partyToWalletMap[partyName];
    }

    function getPartyBalance(string memory partyName) public view returns (uint) {
        return s_partyBalances[partyName];
    }
}
