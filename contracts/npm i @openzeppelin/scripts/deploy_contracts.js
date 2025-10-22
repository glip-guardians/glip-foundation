// scripts/deploy_contracts.js
const hre = require("hardhat");

async function main() {
  const NAME = "GLIP Token";
  const SYMBOL = "GLIP";
  const TREASURY = "0xC77F4ECe838dEa4A045c1323e5a41a36B043280E"; // 멀티시그 주소
  const INITIAL_SUPPLY = 6_000_000_000; // 60억 (소수점 전)

  const [deployer] = await hre.ethers.getSigners();
  console.log("Deployer:", deployer.address);

  const GLIP = await hre.ethers.getContractFactory("GLIPToken");
  const glip = await GLIP.deploy(NAME, SYMBOL, TREASURY, INITIAL_SUPPLY);
  await glip.waitForDeployment();

  const addr = await glip.getAddress();
  console.log("GLIP deployed at:", addr);

  const total = await glip.totalSupply();
  console.log("totalSupply:", total.toString()); // 60억 * 10^18

  // Ownable 사용 시 소유자 이전(생성자 owner=deployer) → 멀티시그로 이전
  if (glip.owner) {
    const owner = await glip.owner();
    console.log("Owner (before):", owner);
    if (owner.toLowerCase() !== TREASURY.toLowerCase()) {
      const tx = await glip.transferOwnership(TREASURY);
      await tx.wait();
      console.log("Owner (after):", await glip.owner());
    }
  }

  // 검증 인자 출력(verify에 사용)
  console.log("Verify args:", [NAME, SYMBOL, TREASURY, INITIAL_SUPPLY]);
}

main().catch((e) => { console.error(e); process.exit(1); });
