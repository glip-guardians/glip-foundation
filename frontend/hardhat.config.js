require('dotenv').config();
require('@nomiclabs/hardhat-ethers'); // ethers v5 plugin

const { ALCHEMY_URL, INFURA_URL, PRIVATE_KEY, ETHERSCAN_API_KEY } = process.env;

module.exports = {
  solidity: {
    version: '0.8.20',
    settings: { optimizer: { enabled: true, runs: 200 } }
  },
  networks: {
    mainnet: {
      url: ALCHEMY_URL || INFURA_URL,
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : []
    }
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY || ''
  }
};
