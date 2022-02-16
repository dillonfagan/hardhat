const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MutualToken", function () {
  it("works", async function () {
    const MutualToken = await ethers.getContractFactory("MutualToken");
    const token = await MutualToken.deploy("PVD", 2_500);
    await token.deployed();

    expect(await token.balance()).to.equal(0);
  });
});
