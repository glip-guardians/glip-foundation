// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RebateManager {
    address public admin;
    uint256 public rebateRateBps; // basis points (e.g., 2500 = 25%)
    event RebateRateUpdated(uint256 oldRate, uint256 newRate);

    constructor(uint256 _rateBps) {
        admin = msg.sender;
        rebateRateBps = _rateBps;
    }

    modifier onlyAdmin() { require(msg.sender == admin, "not admin"); _; }

    function setRebateRate(uint256 _rateBps) external onlyAdmin {
        require(_rateBps <= 10_000, "max 100%");
        emit RebateRateUpdated(rebateRateBps, _rateBps);
        rebateRateBps = _rateBps;
    }
}
