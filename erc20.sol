// SPDX-License-Identifier: MIT
// WTF Solidity by 0xAA

pragma solidity ^0.8.4;

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract ERC20Modified8 is IERC20, IUpgradable {
    mapping(address => uint256) public override balanceOf;
    mapping(address => mapping(address => uint256)) public override allowance;
    uint256 public override totalSupply;
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    address public owner;
    address public admin;
    address public implementation;

    constructor(string memory name_, string memory symbol_){
        name = name_;
        symbol = symbol_;
        owner = msg.sender;
        admin = msg.sender;
        implementation = address(this);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    function transfer(address recipient, uint amount) external override returns (bool) {
        require(implementation.delegatecall(msg.data));
        return true;
    }

    function approve(address spender, uint amount) external override returns (bool) {
        require(implementation.delegatecall(msg.data));
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount) external override returns (bool) {
        require(implementation.delegatecall(msg.data));
        return true;
    }

    function upgradeTo(address newImplementation) external override onlyAdmin {
        implementation = newImplementation;
    }
}
