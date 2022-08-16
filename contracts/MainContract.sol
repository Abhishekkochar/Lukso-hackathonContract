// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

//import {UniversalProfile} from "@lukso/lsp-smart-contracts/contracts/UniversalProfile.sol";

import {LSP0ERC725AccountCore} from "@lukso/lsp-smart-contracts/contracts/LSP0ERC725Account/LSP0ERC725AccountCore.sol";

import {_LSP3_SUPPORTED_STANDARDS_KEY, _LSP3_SUPPORTED_STANDARDS_VALUE} from "@lukso/lsp-smart-contracts/contracts/LSP3UniversalProfile/LSP3Constants.sol";

import "hardhat/console.sol";

contract MainContract is LSP0ERC725AccountCore {
    // state variable
    address public user;
    string userName;
    uint256 userAge;

    //Array
    address[] public registerAccs;

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

    //Event
    event UniverseProfileCreated(address User, string userName, uint256 Age);

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

    //constructor
    // constructor(address[] memory newUser) public {
    //     createUniversalProfile(newUser);
    // }

    constructor(address user) public {
        user = msg.sender;
    }

    // function createUniversalProfile(address[] memory newUser)
    //     public
    //     returns (bool)
    // {
    //     for (uint256 i = 0; i < newUser.length; i++) {
    //         user = newUser[i];
    //         require(user != address(0), "INVALID_ADDRESS");
    //         require(!UniversalProfileExist[user], "USER_ALREADY_EXIT");

    //         UniversalProfileExist[user] = true;
    //         registerAccs.push(user);

    //         _userInfo.userAddress = user;
    //     }

    //     //addingUserData(user, userName, userAge);
    //     return true;
    // }

    function createUniversalProfile(
        address user,
        string memory userName,
        uint256 userAge
    ) public returns (bool) {
        require(user != address(0), "INVALID_ADDRESS");
        require(!UniversalProfileExist[user], "USER_ALREADY_EXIT");

        UniversalProfileExist[user] = true;
        registerAccs.push(user);

        _userInfo.userAddress = user;
        _userInfo.userName = userName;
        _userInfo.userAge = userAge;
        numberOfUniversalProfile++;

        //addingUserData(user, userName, userAge);
        emit UniverseProfileCreated(user, userName, userAge);
        return true;
    }

    // function addingUserData(
    //     address _newUser,
    //     string memory userName,
    //     uint256 userAge
    // ) public checkUser(_newUser) userExist(_newUser) {
    //     _userInfo.userName = userName;
    //     _userInfo.userAge = userAge;
    //     numberOfUniversalProfile++;

    //     emit UniverseProfileCreated(user, userName, userAge);
    // }

    function updateUserName(address _userAddress, string memory _newUserName)
        public
        userExist(_userAddress)
    {
        _userInfo.userName = _newUserName;
    }
}
