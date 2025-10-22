const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("GLIPToken", function () {
  it("mints initial supply to treasury and sets metadata", async () => {
    const [deployer, treasury] = await ethers.getSigners();

    const NAME = "GLIP Token";
    const SYMBOL = "GLIP";
    const INITIAL_SUPPLY = 6_000_000_000;

    const GLIP = await ethers.getContractFactory("GLIPToken");
    const glip = await GLIP.deploy(NAME, SYMBOL, treasury.address, INITIAL_SUPPLY);
    await glip.waitForDeployment();

    expect(await glip.name()).to.equal(NAME);
    expect(await glip.symbol()).to.equal(SYMBOL);

    const decimals = await glip.decimals();
    const total = await glip.totalSupply();
    expect(total).to.equal(BigInt(INITIAL_SUPPLY) * (10n ** BigInt(decimals)));

    const bal = await glip.balanceOf(treasury.address);
    expect(bal).to.equal(total);
  });
});

