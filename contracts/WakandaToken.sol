// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;
contract Token {
    function totalSupply() external view virtual returns (uint256 supply) {}
    function balanceOf(address _owner) public view virtual returns (uint256 balance) {}
    function transfer(address _to, uint256 _value) public virtual returns (bool success) {}
    function transferFrom(address _from, address _to, uint256 _value) virtual public returns (bool success) {}
    function approve(address _spender, uint256 _value) public  virtual returns (bool success) {}
    function allowance(address _owner, address _spender) public view virtual returns (uint256 remaining) {}

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
}

contract StandardToken is Token {

    function transfer(address _to, uint256 _value) public override returns (bool success) {
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success) {
        if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            emit Transfer(_from, _to, _value);
            return true;
        } else { return false; }
    }

    function balanceOf(address _owner) public  view override returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public override returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view override returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    uint256 public override totalSupply;
}


contract WKNDToken is StandardToken {

    fallback() external {
        //if ether is sent to this address, send it back.
        revert();
    }

    string public name;                   
    uint8 public decimals;                
    string public symbol;                
    string public version = 'H1.0';     


    function TokenWKND () public {
        balances[msg.sender] = 100000000000000000000;               
        totalSupply = 100000000000000000000;                        
        name = "WKND Token";                                   
        decimals = 18;                           
        symbol = "WKND";                             
    }

    function approveAndCall (address  _spender, uint256   _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);        
        
        return true;
    }
}