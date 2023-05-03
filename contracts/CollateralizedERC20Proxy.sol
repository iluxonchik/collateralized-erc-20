pragma solidity >=0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "./CollateralizedERC20.sol";

/**
 * @title CollateralizedERC20Proxy
 * @notice The CollateralizedERC20Proxy contract creates an ERC20 token that is fully backed by another ERC20 token, known as collateral.
 * This effectively creates a wrapped ERC20 token with a value that is pegged to the value of the collateral token.
 *
 * This contract acts as a proxy and allows for the creation and minting of CollateralizedERC20 tokens backed by any ERC20 token.
 *
 * The CollateralizedERC20Proxy contract is responsible for deploying instances of CollateralizedERC20 tokens and serves as an entry point for the minting process.
 */
contract CollateralizedERC20Proxy is Ownable {
    address[] public collateralizedERC20s;
    mapping(address => address) public collateralTokenToCollateralizedERC20;

    /**
    * @dev Mints an ERC-20 token that is fully collateralized by another ERC-20 token. 
    * Requirements: 
    *  - The caller of this function must be the owner of the contract, as only the contract owner can mint tokens.
       If you want to allow anyone to mint tokens backed by a collateral, you can remove the onlyOwner modifier.

    * @return The address of the newly minted collateralized token.
    */
    function collateralizedMint(
        address token,
        uint256 amount,
        address to
    ) public onlyOwner returns (address) {
        CollateralizedERC20 collateralizedToken;

        if (
            address(collateralTokenToCollateralizedERC20[token]) == address(0)
        ) {
            collateralizedToken = new CollateralizedERC20(token);
            address collateralizedERC20Addr = address(collateralizedToken);

            collateralTokenToCollateralizedERC20[
                token
            ] = collateralizedERC20Addr;
            collateralizedERC20s.push(collateralizedERC20Addr);
        } else {
            collateralizedToken = CollateralizedERC20(
                collateralTokenToCollateralizedERC20[token]
            );
        }

        IERC20 collateralTokenContract = IERC20(token);
        collateralTokenContract.transferFrom(msg.sender, address(this), amount);
        collateralTokenContract.approve(address(collateralizedToken), amount);

        collateralizedToken.mintFromCollateral(amount, to);

        return address(collateralizedToken);
    }
}
