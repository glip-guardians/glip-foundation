// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title GLIP Token (Standard ERC-20)
 * @notice - 고정 발행(총량은 생성자에서만 민트)
 *         - Burn 가능(선택)
 *         - Permit(EIP-2612) 지원으로 가스 없이 approve
 * @dev 리베이트/스테이킹/거버넌스 로직은 별도 컨트랙트로 분리하세요.
 */
contract GLIPToken is ERC20, ERC20Burnable, ERC20Permit, Ownable {
    // 고정 발행형: 추가 mint 함수 제공하지 않음

    constructor(
        string memory _name,                 // ex) "GLIP Token"
        string memory _symbol,               // ex) "GLIP"
        address treasury,                    // 초기 물량 수령자(멀티시그 권장)
        uint256 initialSupply                // 소수점 전 수치(예: 1_000_000_000)
    )
        ERC20(_name, _symbol)
        ERC20Permit(_name)
        Ownable(msg.sender)                  // 배포자 → 즉시 멀티시그로 이전 권장
    {
        require(treasury != address(0), "treasury=0");
        // 18 decimals 기준으로 스케일 확장
        _mint(treasury, initialSupply * 10 ** decimals());
    }

    // decimals()는 ERC20 기본값 18을 사용(override 불필요)
}
