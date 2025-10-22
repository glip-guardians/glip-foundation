// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title GLIP Token (Standard ERC-20)
 * @dev - 고정 발행(생성자에서만 민트)
 *      - Burn 가능
 *      - Permit(EIP-2612) 지원
 *      - 리베이트/스테이킹은 별도 컨트랙트에서 처리 (표준성 유지)
 */
contract GLIPToken is ERC20, ERC20Burnable, ERC20Permit, Ownable {
    constructor(
        string memory _name,           // e.g., "GLIP Token"
        string memory _symbol,         // e.g., "GLIP"
        address treasury,              // 초기 물량 수령자(멀티시그 권장)
        uint256 initialSupply          // 소수점 전 수량(예: 6_000_000_000)
    )
        ERC20(_name, _symbol)
        ERC20Permit(_name)
        Ownable(msg.sender)
    {
        require(treasury != address(0), "treasury=0");
        _mint(treasury, initialSupply * 10 ** decimals());
    }
}
