// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
//npx hardhat run --network localhost scripts/deploy.js

const hre = require("hardhat");

async function main() {

  const PresentFinder = await hre.ethers.getContractFactory("PresentFinder");
  const pres = await PresentFinder.deploy();

  await pres.deployed();

  console.log(
    `present finder deployed to ${pres.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
