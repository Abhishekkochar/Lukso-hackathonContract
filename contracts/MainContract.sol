// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

//import {ERC725Account} from "./ERC725Account.sol";
import {UniversalProfile} from "@lukso/lsp-smart-contracts/contracts/UniversalProfile.sol";


contract MainContract is UniversalProfile {

    //errors
    error invalid_Address();
    error address_Exists();

    //Structs
    struct userInfo{
        string userName;
        uint256 userAge;
        string profileInfo;
    }

    //mapping 
    mapping (address => userInfo) registerUsers;
    mapping(address => bool) public UniversalProfileExist;

    //arrays
    address[] public registerAccs;
    
    //modifiers
    modifier checkUser {
        if(UniversalProfileExist == false){
            revert address_Exists();
        }
        _;
    }

    modifier NotZeroAddress(address userAddress) {
        if (userAddress !== '0x0'){
            revert invalid_Address();
        }
        _;
    }





}