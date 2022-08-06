// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

//import {ERC725Account} from "./ERC725Account.sol";
import {UniversalProfile} from "@lukso/lsp-smart-contracts/contracts/UniversalProfile.sol";


contract MainContract is UniversalProfile {

    //UniversalProfile Profile userProfile = new UniversalProfile();

    //errors
    error invalid_Address();
    error address_Exists();

    //Structs
    struct userInfo{
        string userName;
        uint256 userAge;
    }

    //mapping 
    mapping (address => userInfo) registerUsers;
    mapping(userProfile => bool) public UniversalProfileExist;

    //arrays
    address[] public registerAccs;
    
    //modifiers
    modifier checkUser {
        if(UniversalProfileExist == false){
            revert address_Exists();
        }
        _;
    }

    modifier notZeroAddress(address userAddress) {
        if (userAddress !== '0x0'){
            revert invalid_Address();
        }
        _;
    }

    constructor(address _newOwner) UniversalProfile(newOwner) payable {
        // // set key SupportedStandards:LSP3UniversalProfile
        // _setData(_LSP3_SUPPORTED_STANDARDS_KEY, _LSP3_SUPPORTED_STANDARDS_VALUE);
    }

    function createUniversalProfile(address userAddress) public checkUser notZeroAddress {
        (bool success, ) = userAddress.delegatecall(
            abi.encodeWithSelector()
        )
    }







}