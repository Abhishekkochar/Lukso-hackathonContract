// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import {UniversalProfile} from "@lukso/lsp-smart-contracts/contracts/UniversalProfile.sol";
import "hardhat/console.sol";

contract MainContract is UniversalProfile {
    // state variable
    address public newOwner;

    //errors
    error invalid_Address();
    error address_Exists();
    error user_Not_Exist();

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
    modifier checkUser(address newOwner) {
        if (UniversalProfileExist[newOwner] == false) {
            revert address_Exists();
        }
        _;
    }

    modifier userExist(address _userAddress) {
        if (UniversalProfileExist[_userAddress] == true) {
            revert user_Not_Exist();
        }
        _;
    }

    modifier notZeroAddress() {
        if (msg.sender != address(0)) {
            revert invalid_Address();
        }
        _;
    }

    constructor(address newOwner) UniversalProfile(newOwner) {
        console.log("Current owner: ", newOwner);
    }

    function createUniversalProfile(
        address newOwner,
        string memory _userName,
        uint256 _userAge
    ) public checkUser(newOwner) notZeroAddress returns (bool) {
        _userInfo.userAddress = newOwner;
        _userInfo.userName = _userName;
        _userInfo.userAge = _userAge;
        UniversalProfileExist[newOwner] = true;
        registerAccs.push(newOwner);
        numberOfUniversalProfile++;

        console.log("Current owner in CUP: ", newOwner);

        return true;
    }

    function updateUserName(address _userAddress, string memory _newUserName)
        public
        userExist(_userAddress)
    {
        _userInfo.userName = _newUserName;
    }

    // function changeAddress(address _oldAddress, address _newAddress)
    //     public
    //     userExist(_oldAddress)
    // {
    //     //when user wants to change their address
    // }

    // function deleteUniversalProfile(address _userAddress)
    //     public
    //     userExist(_userAddress)
    // {
    //     //when user wants to delete their account
    // }
}
