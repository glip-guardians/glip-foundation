const { ethers } = require('hardhat');

async function main() {
  const { GLIP_ADDRESS, SALE_ADDRESS, FUND_AMOUNT } = process.env;
  if(!GLIP_ADDRESS || !SALE_ADDRESS || !FUND_AMOUNT) {
    throw new Error('Missing env: GLIP_ADDRESS, SALE_ADDRESS, FUND_AMOUNT');
  }
  const erc20Abi = [
    'function transfer(address to, uint256 amount) public returns (bool)',
    'function decimals() public view returns (uint8)'
  ];
  const signer = (await ethers.getSigners())[0];
  const glip = new ethers.Contract(GLIP_ADDRESS, erc20Abi, signer);
  const decimals = await glip.decimals();
  const amt = ethers.utils.parseUnits(FUND_AMOUNT, decimals);
  const tx = await glip.transfer(SALE_ADDRESS, amt);
  console.log('Funding tx:', tx.hash);
  await tx.wait();
  console.log('Funded', FUND_AMOUNT, 'GLIP to', SALE_ADDRESS);
}
main().catch((e)=>{ console.error(e); process.exit(1); });
