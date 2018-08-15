const HDWalletProvider = require('truffle-hdwallet-provider'); //provider for connecting to remote test network
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
	'glove lion what evolve finish indicate occur divert liquid legal smoke noodle', //account mnemonic 
	'https://rinkeby.infura.io/v3/12e751a7679242c1b5df99946436c179' //API endpoint from Infura
);
const web3 = new Web3(provider);

const deploy = async () => {
	const accounts = await web3.eth.getAccounts();

	console.log('Attempting to deploy from account ', accounts[0]);

	const result = await new web3.eth.Contract(JSON.parse(interface))
		.deploy({ data: '0x' + bytecode })
		.send({ from: accounts[0], gas: '1000000' });

	console.log('Contract deployed to ', result.options.address);
};

deploy();	