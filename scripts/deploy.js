const { ethers } = require("hardhat");

async function main() {
  const InsuranceProvider = await ethers.getContractFactory("InsuranceProvider");
  const insuranceProvider = await InsuranceProvider.deploy();
  const address = await insuranceProvider.getAddress();
  console.log("Insurance Provider deployed to:", address);
}

main()
 .then(() => process.exit(0))
 .catch(error => {
  console.error(error);
  process.exit(1);
});
