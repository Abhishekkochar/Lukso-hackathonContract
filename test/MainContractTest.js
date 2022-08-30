const { expect } = require("chai");
const { ethers } = require("hardhat");
const { expectRevert } = require('@openzeppelin/test-helpers');
const Table = require("cli-table3");

describe("Creating an Universal profile", function () {
    let universalProfile;

    table = new Table({
        head: ['Contracts', 'Contact Address'],
        colWidths: ['auto', 'auto']
    });

    beforeEach(async function () {
        [deployingAddress, userAcc1, userAcc2, userAcc3, notUser1] = await ethers.getSigners();

        //deploying the contract

        //ownerArray = [userAcc1.address];

        const uProfile = await hre.ethers.getContractFactory("MainContract");
        universalProfile = await uProfile.deploy(deployingAddress.address);

        table.push(
            ['Deploying Address is: ', deployingAddress.address],
            ['Contract deploy address: ', universalProfile.address],
            ['userAcc1 address: ', userAcc1.address],
            ['userAcc2 address: ', userAcc2.address],
            ['Notuser Address: ', notUser1.address]
        )
    })

    it("Contract deployment: ", async function () {
        console.log(table.toString());
    })

    it("UserAcc1 creates a Uinversal Profile", async function () {
        let userAddress1, userAddress2, userAddress3, userName, userAge;
        //first test
        userAddress1 = userAcc1.address;
        userName = "Sam";
        userAge = "27";
        await universalProfile.createUniversalProfile(userAddress1, userName, userAge);
        let result = await universalProfile._userInfo();
        console.log("user 1 details: ", result);
        console.log('user 1 profile exist: ', universalProfile.UniversalProfileExist());

        //Second test
        userAddress2 = userAcc2.address;
        userName = "Amit";
        userAge = "30";
        await universalProfile.createUniversalProfile(userAddress2, userName, userAge);
        result = await universalProfile._userInfo();
        console.log("user 2 details: ", result);

        //third test
        userAddress3 = userAcc3.address;
        userName = "Abhi";
        userAge = "35";
        await universalProfile.createUniversalProfile(userAddress3, userName, userAge);
        result = await universalProfile._userInfo();
        console.log("user 3 details: ", result);

        //userAddress 1, 2 and 3 try to resgiter again;
        await expectRevert.unspecified(universalProfile.createUniversalProfile(userAcc1.address, "alreadyExist", "20"));
        await expectRevert.unspecified(universalProfile.createUniversalProfile(userAcc2.address, "alreadyExist", "20"));
        await expectRevert.unspecified(universalProfile.createUniversalProfile(userAcc3.address, "alreadyExist", "20"));
        //Inavlid address
        let invalidAddress = "0x0000000000000000000000000000000000000000"
        await expectRevert.unspecified(universalProfile.createUniversalProfile(invalidAddress, "alreadyExist", "20"));

        result = await universalProfile.numberOfUniversalProfile();
        console.log("Number of UP: ", result);

        // let newName = "David";
        // await universalProfile.connect(userAddress1).updateUserName(userAddress1, newName);


    })
})