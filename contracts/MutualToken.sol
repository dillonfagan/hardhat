// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract MutualToken {
    mapping(address => int256) balances;
    string public symbol;
    uint256 public creditLimit;

    constructor(string memory _symbol, uint256 _creditLimit) {
        symbol = _symbol;
        creditLimit = _creditLimit;
    }

    modifier hasCredit(uint256 _amount) {
        int256 remainingCredit = int256(creditLimit) - balances[tx.origin];
        require(remainingCredit >= int256(_amount));
        _;
    }

    function send(address _receiver, uint256 _amount) public hasCredit(_amount) {
        int256 _exchangeAmount = int256(_amount);
        balances[tx.origin] += _exchangeAmount;
        balances[_receiver] -= _exchangeAmount;
    }

    function balance() public view returns (int256) {
        return balances[tx.origin];
    }
}