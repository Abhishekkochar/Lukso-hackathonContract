const { expect } = require("chai");
const { ethers } = require("hardhat");
//const { expectRevert } = require('@openzeppelin/test-helpers');
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
        universalProfile = await uProfile.connect(deployingAddress).deploy(userAcc1.address);

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
        let userAddress, userName, userAge;
        userAddress = userAcc1.address;
        userName = "Change name";
        userAge = "27";
        await universalProfile.createUniversalProfile(userAddress, userName, userAge);
        let address = await universalProfile.user();
        console.log('userAcc1 address: ', address);
        // let result = await universalProfile.userName();
        // console.log('userAcc1 change Username: ', result);
    })
})