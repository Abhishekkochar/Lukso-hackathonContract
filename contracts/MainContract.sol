// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import {UniversalProfile} from "@lukso/lsp-smart-contracts/contracts/UniversalProfile.sol";

contract MainContract is UniversalProfile {
    //errors
    error invalid_Address();
    error address_Exists();

    //Structs
    struct userInfo {
        address userAddress;
        string userName;
        uint256 userAge;
    }

    userInfo public _userInfo;
    uint256 numberOfUniversalProfile;

    //mapping
    mapping(address => bool) public UniversalProfileExist;

    //arrays
    address[] public registerAccs;

    //modifiers
    modifier checkUser(address _userAddress) {
        if (UniversalProfileExist[_userAddress] == false) {
            revert address_Exists();
        }
        _;
    }

    modifier notZeroAddress() {
        if (msg.sender != address(0)) {
            revert invalid_Address();
        }
        _;
    }

    constructor(address newOwner) UniversalProfile(newOwner) {}

    function createUniversalProfile(
        address _userAddress,
        string memory _userName,
        uint256 _userAge
    ) public checkUser(_userAddress) notZeroAddress returns (bool) {
        _userInfo.userAddress = _userAddress;
        _userInfo.userName = _userName;
        _userInfo.userAge = _userAge;
        UniversalProfileExist[_userAddress] = true;
        registerAccs.push(_userAddress);
        numberOfUniversalProfile++;

        return true;
    }

    function updateUserName(address _userAddress, string memory _newUserName)
        public
        checkUser(_userAddress)
    {
        _userInfo.userName = _newUserName;
    }

    function changeAddress(address _oldAddress, address _newAddress)
        public
        checkUser(_oldAddress)
    {
        //when user wants to change their address
    }

    function deleteUniversalProfile(address _userAddress)
        public
        checkUser(_userAddress)
    {
        //when user wants to delete their account
    }
}
