require('dotenv').config()
const Web3 = require('web3');
const { LSPFactory } = require('@lukso/lsp-factory.js');

const web3 = new Web3();

const PRIVATE_KEY = "439a4c3d2da5717ee89e4cb114830998814706fdf4664ec00857221c6ff7bdb3"

const myEOA = web3.eth.accounts.privateKeyToAccount(PRIVATE_KEY);


const lspFactory = new LSPFactory('https://rpc.l14.lukso.network', {
    deployKey: PRIVATE_KEY,
    chainId: 22,
});

//console.log('address: ' + ERC725Account.address);

//Deploy our Universal Profile
async function createUniversalProfile() {
    const deployedContracts = await lspFactory.UniversalProfile.deploy({
        controllerAddresses: [myEOA.address],
        lsp3Profile: {
            name: 'My Universal Profile',
            description: 'My Cool Universal Profile',
            tags: ['Public Profile'],
            links: [
                {
                    title: 'My Website',
                    url: 'https://my-website.com',
                },
            ],
        },
    });

    const myUPAddress = deployedContracts.ERC725Account.address;
    console.log('my Universal Profile address: ', myUPAddress);

    return deployedContracts;
}

createUniversalProfile();


// my Universal Profile address: 0x05bC54940E37a2AF7fB0D3caBd27Ee66795f7f91;
//my Private key = '0x439a4c3d2da5717ee89e4cb114830998814706fdf4664ec00857221c6ff7bdb3'