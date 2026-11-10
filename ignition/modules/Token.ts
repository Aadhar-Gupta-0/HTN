import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("Token", (m) => {
  const owner = m.getAccount(0);
  const initialSupply = m.getParameter("initialSupply", 1000000n * 10n ** 18n);
  const maxSupply = m.getParameter("maxSupply", 10000000n * 10n ** 18n);
  const token = m.contract("Token", [owner, initialSupply, maxSupply]);
  return { token };
});
