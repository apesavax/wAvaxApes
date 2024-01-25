require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-verify");
require("dotenv").config({ path: __dirname + "/.env" });

module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      },
      evmVersion: "paris"
    }
  },
  etherscan: {
    apiKey: {
      snowtrace: "snowtrace", // apiKey is not required, just set a placeholder
      lore: "lore-public"
    },
    customChains: [
      {
        network: "snowtrace",
        chainId: 43114,
        urls: {
          apiURL: "https://api.routescan.io/v2/network/mainnet/evm/43114/etherscan",
          browserURL: "https://avalanche.routescan.io"
        }
      },
      {
        network: "lore",
        chainId: 43114,
        urls: {
          apiURL: " https://api.lorescan.com/43114",
          browserURL: "https://skilift.io/"
        }
      }
    ]
  },
  networks: {
    snowtrace: {
      url: 'https://api.avax.network/ext/bc/C/rpc',
      accounts: [process.env.PRIVATE_KEY]
    },
    lore: {
      url: 'https://api.avax.network/ext/bc/C/rpc',
      accounts: [process.env.PRIVATE_KEY]
    },
    fuji: {
      url: 'https://api.avax-test.network/ext/bc/C/rpc',
      accounts: [process.env.PRIVATE_KEY]
    },
  },
};
