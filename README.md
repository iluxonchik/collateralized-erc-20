# Collateralized ERC-20 Token

📚 **TL;DR:** This repository presents a set of smart contracts for creating Collateralized ERC-20 tokens. These tokens are backed by other ERC-20 tokens, providing a lower bound for their value and stability. Collateralized ERC-20 tokens can be used in various applications, such as loyalty tokens, stablecoins, asset-backed tokens, and tokenized commodities. 🚀

---

## Introduction

The Collateralized ERC-20 Token project aims to provide a framework for creating ERC-20 tokens that are fully backed by another ERC-20 token, known as collateral. Collateralized tokens play an essential role in the blockchain ecosystem by offering stability and a value pegged to an underlying asset. This README will guide you through the concept of collateralization in economics, use cases for collateralized ERC-20 tokens, and how to integrate them into your project.

## Collateralization in Economics

Collateralization is the process of securing a loan or other financial obligation by pledging an asset as collateral. In the context of currencies, collateralization serves to establish a lower bound for the currency's value, which is determined by the value of the underlying collateral.

Historically, collateralization has been used to back currencies with tangible assets such as gold, silver, or other commodities. These commodity-backed currencies provided a stable value for the currency and allowed for trust in its redeemability for the underlying asset.

## Collateralized ERC-20 Token

A collateralized ERC-20 token is an ERC-20 token whose value is pegged to another ERC-20 token, known as the collateral. These tokens are created using smart contracts that lock the collateral in exchange for the minting of new tokens, ensuring that the collateralized tokens are fully backed by the underlying asset. The provided smart contracts in this project work together to create a collateralized ERC-20 token:

- `CollateralizedERC20.sol`: The core contract responsible for creating the collateralized tokens, minting new tokens, and allowing users to burn tokens and retrieve their collateral.
- `CollateralizedERC20Proxy.sol`: A proxy contract that deploys instances of `CollateralizedERC20` tokens and serves as an entry point for the minting process.

## Use Cases for Collateralized ERC-20 Tokens

Collateralized ERC-20 tokens can be used in various applications within the blockchain ecosystem, including:

- **Stablecoins**: Tokens that are pegged to a stable asset, such as a fiat currency or a commodity, to provide stability and minimize price volatility.
- **Asset-backed tokens**: Tokens that represent ownership in real-world assets, such as stocks, bonds, or real estate.
- **Tokenized commodities**: Tokens that represent ownership in commodities like gold, silver, or other resources, enabling easier trading and investment in these assets.

These use cases can provide benefits to different industries and projects, such as increased stability, transparency, and accessibility of assets.

## Integrating Collateralized ERC-20 Tokens into Your Project

To integrate a collateralized ERC-20 token into your project, follow these steps:

1. Understand the provided smart contracts (`CollateralizedERC20.sol` and `CollateralizedERC20Proxy.sol`), their functions, and their interactions.
2. Customize the smart contracts as needed to fit your project's requirements.
3. Deploy the smart contracts to Ethereum, or another EVM-compatible network using your preferred method (e.g., Remix, Brownie, Truffle, etc.).

Please note that familiarity with Solidity and the Ethereum ecosystem is required to successfully integrate collateralized ERC-20 tokens into your project.

## API Description and Usage

The API provides several functions and events to interact with the collateralized ERC-20 token and the deployer proxy. Below is a guide on how to use these functions:

### Initializing the CollateralizedERC20Proxy contract

Deploy the `CollateralizedERC20Proxy` contract on the Ethereum network. This contract will be used to deploy instances of `CollateralizedERC20` tokens and serve as an entry point for the minting process.

### Creating and minting new collateralized tokens

To create and mint new collateralized tokens, call the `collateralizedMint` function on the `CollateralizedERC20Proxy` contract:

```solidity
function collateralizedMint(address token, uint256 amount, address to) public onlyOwner returns (address)
```

This function takes the following parameters:

- `token`: The address of the ERC-20 token that will serve as collateral.
- `amount`: The amount of collateral tokens to lock and the corresponding amount of collateralized tokens to mint.
- `to`: The recipient address for the newly minted collateralized tokens.

The function will return the address of the newly minted collateralized token.

### Burning tokens and retrieving collateral

To burn collateralized tokens and retrieve the underlying collateral, call the `burnAndRetrieveCollateral` function on the `CollateralizedERC20` contract:

```solidity
function burnAndRetrieveCollateral(uint256 amount) external
```

This function takes the following parameter:

- `amount`: The amount of collateralized tokens to burn.

Upon successful execution, the function will transfer the corresponding amount of collateral tokens back to the sender's address.

### Chaining of collateralized ERC-20 tokens

Although it is not covered under this implementation, it is possible to further ERC-20 collateralezation to either a set of ERC-20 tokens or chain several collateralized tokens into
a single one. It is fairly straighforward to extend this implementation to support it. If you need assistance, create an issue under this repository.

## Notes about this implementation

This implementation was initially developed as part of a project that issues loyalty tokens in the form of collateralized ERC-20 tokens. By creating collateralized ERC-20 tokens as loyalty
tokens, an intrinsic value is added to the tokens issued by the platform, providing a lower bound for their value and makes them immune to inflation. The users of your platform gain a lot,
as even if the project fails, the value of the project's loyalty tokens will always be protected by the value of the token that backs them.

Please note that this set of smart contracts was developed within a specific context, and you are encouraged to adapt it to your needs.

I decided to include this in a separate repository in order to further promote and expose the idea of collateralized ERC-20 tokens, as I believe their widespread use will provide a
great value for DeFi applications on the blockchain, and Web 3 in general.

### Tests

It's important to note that this project currently lacks tests. This is not due to a disregard for testing; rather, the implementation will be tested within a separate project.
The code for this set of smart contracts has been carefully crafted and packaged into this repository for the reasons mentioned above. However, please be aware that
**this code is not production-ready** and should undergo thorough testing and potential modifications before being deployed and used in a production environment.

## Conclusion

Collateralized ERC-20 tokens offer stability and versatility by providing a value pegged to an underlying asset. This project enables the creation of collateralized ERC-20 tokens that can be used in various applications, such as stablecoins, asset-backed tokens, and tokenized commodities. Developers are encouraged to consider using collateralized ERC-20 tokens in their projects to add value and functionality.

## References and Resources

To further understand and work with ERC-20 tokens and Solidity, refer to the following resources:

- [Official Ethereum and ERC-20 documentation](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/)
- [OpenZeppelin documentation and resources](https://docs.openzeppelin.com/contracts/4.x/)
- [Tutorials and guides on working with ERC-20 tokens and Solidity](https://solidity.readthedocs.io/)
