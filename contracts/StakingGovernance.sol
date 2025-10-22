// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StakingGovernance {
    struct Proposal {
        string title;
        uint256 endBlock;
        uint256 forVotes;
        uint256 againstVotes;
        bool executed;
    }
    Proposal[] public proposals;

    function propose(string calldata _title, uint256 _durationBlocks) external returns (uint256) {
        proposals.push(Proposal({
            title: _title,
            endBlock: block.number + _durationBlocks,
            forVotes: 0,
            againstVotes: 0,
            executed: false
        }));
        return proposals.length - 1;
    }
}
