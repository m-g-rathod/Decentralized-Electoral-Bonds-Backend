// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ElectoralBond {
    mapping (string => address) private s_partyToWalletMap;
    mapping(address => uint) private userBalances;

    function purchaseBond() public  {
        require(msg.value > 0, "You need to send some Ether");
        userBalances[msg.sender] += msg.value;
    }

    function transferBond(string memory partyName, uint amount) public {
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