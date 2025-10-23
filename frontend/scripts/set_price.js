const { ethers } = require('hardhat');

async function main() {
  const saleAddress = process.env.SALE_ADDRESS;
  if(!saleAddress) throw new Error('Missing SALE_ADDRESS in env');
  const newPriceEth = process.env.NEW_PRICE_ETH;
  if(!newPriceEth) throw new Error('Missing NEW_PRICE_ETH in env (e.g. 0.001)');
  const sale = await ethers.getContractAt('GLIPSale', saleAddress);
  const tx = await sale.setPrice(ethers.utils.parseEther(newPriceEth));
  console.log('setPrice tx:', tx.hash);
  await tx.wait();
  console.log('Done');
}
main().catch((e)=>{ console.error(e); process.exit(1); });
