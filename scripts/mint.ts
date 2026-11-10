import { network } from "hardhat";
import { isAddress, parseUnits } from "viem";

const tokenAddress = process.env.TOKEN_ADDRESS;
const recipient = process.env.MINT_TO;
const rawAmount = process.env.MINT_AMOUNT ?? "1";
if (!tokenAddress || !isAddress(tokenAddress) || !recipient || !isAddress(recipient)) {
  throw new Error("Set TOKEN_ADDRESS and MINT_TO to valid Ethereum addresses.");
}
if (!/^(0|[1-9]\d*)(\.\d{1,18})?$/.test(rawAmount) || Number(rawAmount) <= 0) {
  throw new Error("MINT_AMOUNT must be a positive decimal with <=18 fractional digits.");
}
const { viem } = await network.connect({ network: process.env.HARDHAT_NETWORK || "hardhatMainnet", chainType: "l1" });
const publicClient = await viem.getPublicClient();
const [walletClient] = await viem.getWalletClients();
const token = await viem.getContractAt("Token", tokenAddress, {
  client: { public: publicClient, wallet: walletClient },
});
const amount = parseUnits(rawAmount, await token.read.decimals());
const hash = await token.write.mint([recipient, amount]);
await publicClient.waitForTransactionReceipt({ hash });
console.log("Mint transaction:", hash);
