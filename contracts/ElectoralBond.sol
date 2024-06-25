// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ElectoralBond {

    mapping (string => address) private s_partyToWalletMap;

    function mapAddress (string memory partyName, address waletAddress) public {
        s_partyToWalletMap[partyName] = waletAddress;
    }

    function changeWalletAddress (string memory partyName, address changedWalletAddress) public {
        s_partyToWalletMap[partyName] = changedWalletAddress;
    }

}