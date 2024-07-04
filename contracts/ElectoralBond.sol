// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ElectoralBond {
    mapping (string => address) private s_partyToWalletMap;
    mapping (string => uint) private s_partyBalances;

    function transferBond(string memory partyName) public payable { // bond is ether 
        address to = s_partyToWalletMap[partyName];
        require(to != address(0), "Party not registered");
        require(msg.value > 0, "You need to send some Ether");

        payable(to).transfer(msg.value);
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

    function getPartyBalance(string memory partyName) public view returns (uint) {
        return s_partyBalances[partyName];
    }

}