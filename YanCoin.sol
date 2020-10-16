import "./Ownable.sol";
import "./ERCAbstract.sol";
pragma solidity 0.5.12;

contract YanCoin is ERC20{
    
    string public constant symbol = "YCN";
    string public constant name = "YanCoin";
    uint public constant decimals =18;
    uint private constant __totalSupply = 1000000;
    
    mapping(address=>uint) private _balanceOf;
    mapping(address=> mapping(address=>uint)) private _allowances;
    
    constructor() public{
        _balanceOf[msg.sender]= __totalSupply;
    }
    
    function name() public view returns (string){
        return name;
    }
    
     function symbol() public view returns (string memory) {
         return symbol;
    }

    function decimals() public view returns (uint8) {
        return decimals;
    }
    
    function mint(address account, uint256 amount) public onlyOwner{
        _balanceOf[account] +=amount;
        }
    
    
    function totalSupply() public view returns (uint _totalSupply){
        _totalSupply = __totalSupply;
        return _totalSupply;
    }
    
    function balanceOf(address account) public view onlyOwner returns (uint256) {
        return _balanceOf[account];
    }
    
    function transfer(address _to, uint _value) public returns (bool success){
        if(_value> 0 && _value <=balanceOf(msg.sender)){
            _balanceOf[msg.sender] -= _value;
            _balanceOf[_to] += _value;
            return true;
        }else{
            return false;
        }
    }
    
    function transferFrom(address from, address to, uint value) public returns (bool success){
        if(_allowances[from][msg.sender]>0 
        && value>0
        && _allowances[from][msg.sender]> value
        && _balanceOf[from]>value){
            _allowances[from][msg.sender] -= value;
            _balanceOf[from] -= value;
            _balanceOf[to] += value;
            return true;
        }
        else{
            return false;
        }
    }
    
        function approve(address _spender, uint _value) public returns (bool success) {
        _allowances[msg.sender][_spender] = _value;
        return true;
    }
    
    function allowance(address _owner, address _spender) public view returns (uint remaining) {
        return _allowances[_owner][_spender];
    }
    
}