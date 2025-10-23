const { ethers } = require('hardhat');

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log('Deployer:', deployer.address);

  const GLIP_ADDRESS = process.env.GLIP_ADDRESS || '0xD0b86b79AE4b8D7bb88b37EBe228ce343D79794e';
  const PRICE_WEI_PER_TOKEN = ethers.utils.parseEther(process.env.PRICE_PER_GLIP_ETH || '0.001');

  const Sale = await ethers.getContractFactory('GLIPSale');
  const sale = await Sale.deploy(GLIP_ADDRESS, PRICE_WEI_PER_TOKEN);
  await sale.deployed();
  console.log('GLIPSale deployed at:', sale.address);
}
main().catch((e)=>{ console.error(e); process.exit(1); });
