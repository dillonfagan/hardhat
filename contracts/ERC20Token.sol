// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ERC20Token {
    string public name;
    mapping(address => uint256) public balances;

    constructor(string memory _name) public {
        name = _name;
    }

    function mint() public {
        balances[tx.origin] ++;
    }
}

contract MyToken is ERC20Token {
    string public symbol;
    
    constructor(string memory _name, string memory _symbol) ERC20Token(_name) public {
        symbol = _symbol;
    }
}

contract MyContract {
    address payable wallet;
    address public token;

    constructor(address payable _wallet, address _token) public {
        wallet = _wallet;
        token = _token;
    }

    receive() external payable {
        buyToken();
    }

    function buyToken() public payable {
        ERC20Token(address(token)).mint();
        wallet.transfer(msg.value);
    }
}