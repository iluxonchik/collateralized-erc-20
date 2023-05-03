pragma solidity >=0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

/**
 * @title CollateralizedERC20
 * @notice The CollateralizedERC20 smart contract allows for the creation of an ERC20 token that is fully backed by another ERC20 token, 
 also known as collateral. Essentially, it acts as a wrapper around the collateral token, creating a wrapped ERC20 token that has its 
 value pegged to the value of the collateral token.

To mint a CollateralizedERC20 token, the smart contract requires an equal amount of the collateral ERC20 token to be transferred into 
the smart contract. This ensures that the new token is fully collateralized and can be redeemed for the collateral token at any time.

Similarly, a CollateralizedERC20 token can be burned to retrieve the original collateral ERC20 token. The value of the token will be 
equal to that of the collateral token minus any transaction fees.

Finally, it is worth noting that additional value can be added to a CollateralizedERC20 token by providing it with utility beyond its 
peg to the collateral token.

As such, an instance of CollateralizedERC20 smart contract provides a mechanism for creating a stablecoin-like asset that is fully backed 
by another token, with the added flexibility of being able to add utility on top of its inherent value.
 */
contract CollateralizedERC20 is ERC20, Ownable {
    address public immutable collateralToken;

    function decimals() public view virtual override returns (uint8) {
        return IERC20Metadata(collateralToken).decimals();
    }

    constructor(
        address _collateralToken
    )
        ERC20(
            string.concat("pdf", IERC20Metadata(_collateralToken).symbol()),
            string.concat("PayDeFi ", IERC20Metadata(_collateralToken).name())
        )
    {
        collateralToken = _collateralToken;
    }

    /**
     * @dev Mints tokens from collateral.
     *
     * Requirements:
     *
     * - `msg.sender` must be the owner of the contract. Minting of tokens is only allowed by the owner contract.
     *  You can remove the onlyOwner modifier if you want to allow anyone to mint tokens.
     */
    function mintFromCollateral(
        uint256 amount,
        address recipient
    ) external onlyOwner {
        IERC20(collateralToken).transferFrom(msg.sender, address(this), amount);
        _mint(recipient, amount);
    }

    function burnAndRetrieveCollateral(uint256 amount) external {
        _burn(msg.sender, amount);
        IERC20(collateralToken).transfer(msg.sender, amount);
    }
}
