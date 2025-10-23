// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title GLIPSale
 * @notice ETH -> GLIP fixed-price sale contract (prefunded).
 */
contract GLIPSale is Ownable, Pausable, ReentrancyGuard {
    IERC20 public immutable glip;
    uint256 public priceWeiPerToken; // price for 1 GLIP (18 decimals) in wei

    event Bought(address indexed buyer, uint256 ethIn, uint256 glipOut);
    event PriceUpdated(uint256 oldPrice, uint256 newPrice);

    constructor(address _glip, uint256 _priceWeiPerToken) Ownable(msg.sender) {
        require(_glip != address(0), "GLIP addr zero");
        require(_priceWeiPerToken > 0, "price zero");
        glip = IERC20(_glip);
        priceWeiPerToken = _priceWeiPerToken;
    }

    function calcTokensForEth(uint256 ethWei) public view returns (uint256) {
        return (ethWei * 1e18) / priceWeiPerToken;
    }

    receive() external payable { _buy(msg.sender, msg.value); }

    function buy() external payable whenNotPaused nonReentrant {
        _buy(msg.sender, msg.value);
    }

    function _buy(address buyer, uint256 ethIn) internal {
        require(ethIn > 0, "no ETH");
        uint256 glipOut = calcTokensForEth(ethIn);
        uint256 bal = glip.balanceOf(address(this));
        require(bal >= glipOut, "insufficient GLIP");
        require(glip.transfer(buyer, glipOut), "GLIP transfer failed");
        emit Bought(buyer, ethIn, glipOut);
    }

    function setPrice(uint256 newPrice) external onlyOwner {
        require(newPrice > 0, "price zero");
        emit PriceUpdated(priceWeiPerToken, newPrice);
        priceWeiPerToken = newPrice;
    }

    function withdrawETH(address payable to) external onlyOwner {
        uint256 bal = address(this).balance;
        require(bal > 0, "no ETH");
        to.transfer(bal);
    }

    function withdrawGLIP(address to, uint256 amount) external onlyOwner {
        require(glip.transfer(to, amount), "withdraw failed");
    }

    function pause() external onlyOwner { _pause(); }
    function unpause() external onlyOwner { _unpause(); }
}
