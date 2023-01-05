import '@nomicfoundation/hardhat-toolbox';

module.exports = {
  solidity: {
    version: '0.8.17',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  paths: {
    sources: './contracts',
    tests: './tests',
    artifacts: './artifacts',
    cache: './cache'
  }
};
