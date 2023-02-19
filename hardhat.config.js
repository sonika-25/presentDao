require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-waffle");
const loadJsonFile = require('load-json-file');
const keys = loadJsonFile.sync("./keys.json");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  paths: {
    artifacts: './client/src',
  },
  networks: {
    mumbai: {
      // Infura
      // url: `https://polygon-mumbai.infura.io/v3/${infuraId}`
      url: `https://polygon-mumbai.infura.io/v3/4458cf4d1689497b9a38b1d6bbf05e78`,
      accounts: [keys.networks.mumbai.privateKey]
    },
  },
};
