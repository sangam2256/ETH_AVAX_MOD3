// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

//For this project, you will write a smart contract to create your own token on a local HardHat network. 
//Once you have your contract, you should be able to use remix to interact with it.
// From remix, the contract owner should be able to mint tokens to a provided address.
// Any user should be able to burn and transfer tokens.


contract mySmartContractModule3 {
    
    mapping(address => uint256) public tokenBalances;
    address public holder;
    
    uint256 public tokenTotalSupply;

    modifier onlyholder() {
        require(msg.sender == holder, "Wrong holder!");
        _;
    }

    constructor() {
        holder = msg.sender;
        
    }

    function transferOwnership(address newholder) external onlyholder {
        require(newholder != address(0), "False address");
        holder = newholder;
    }

    function mint(address _to, uint256 amount) external onlyholder {
        require(_to != address(0), "False address");
        require(amount > 0, "Wrong amount");
        tokenTotalSupply += amount;
        tokenBalances[_to] += amount;
    }

    function burn(uint256 amount) external {
        require(amount > 0, "Wrong amount");
        require(tokenBalances[msg.sender] >= amount, "inadequate balance");
        tokenTotalSupply -= amount;
        tokenBalances[msg.sender] -= amount;
    }

    function transfer(address to, uint256 amount) external {
        require(to != address(0), "False address");
        require(amount > 0, "Invalid amount");
        require(tokenBalances[msg.sender] >= amount, "inadequate balance");
        tokenBalances[msg.sender] -= amount;
        tokenBalances[to] += amount;
    }
}
