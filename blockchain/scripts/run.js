const main = async () => {
  const shinChanNFTContractFactory = await hre.ethers.getContractFactory('ShinChanNFT');
  const shinChanNFTContract = await shinChanNFTContractFactory.deploy();
  await shinChanNFTContract.deployed();
  console.log("Contract deployed to:", shinChanNFTContract.address);

  // Calling the function to mint NFT
  let txn = await shinChanNFTContract.makeShinChanNFT();
  await txn.wait(); // waiting to be mined

  txn = await shinChanNFTContract.makeShinChanNFT();
  await txn.wait(); // waiting to be mined
}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1)
  }
};

runMain();