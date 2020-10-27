import "./Ownable.sol";
import "./ERCAbstract.sol";
import "./SafeMath.sol";
pragma solidity 0.5.12;

contract YanCoin is ERC20{
    
    using SafeMath for uint256;
    
    string private  _symbol;
    string private _name;
    uint8 private  _decimals;
    uint private  __totalSupply;
    
    mapping(address=>uint) private _balanceOf;
    mapping(address=> mapping(address=>uint)) private _allowances;
    
    constructor() public{
        _balanceOf[msg.sender]= __totalSupply;
        _symbol = "YCN";
        _name = "YanCoin";
        _decimals = 18;
        __totalSupply = 100;
    }
    
    function name() public view returns (string memory){
        return _name;
    }
    
    function setName(string memory newName) public {
        _name = newName;
    }
    
     function symbol() public view returns (string memory) {
         return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }
    
    function mint(address account, uint256 amount) public onlyOwner{
       __totalSupply = __totalSupply.add(amount);
       _balanceOf[account] = _balanceOf[account].add(amount);
        }
    
    function totalSupply() public view returns (uint _totalSupply){
        _totalSupply = __totalSupply;
        return _totalSupply;
    }
    
    function balanceOf(address account) public view onlyOwner returns (uint256) {
        return _balanceOf[account];
    }
    
    function transfer(address _to, uint _value) public returns (bool success){
        require(_value> 0, "You have to send positive funds, bro" );
        require(_value <=balanceOf(msg.sender), "Don't spend what you don't have, Mr. Trump");
             _balanceOf[msg.sender] = _balanceOf[msg.sender].sub(_value);
            _balanceOf[_to] = _balanceOf[_to].add(_value);
            return true;
    }
    
    function transferFrom(address from, address to, uint value) public returns (bool success){
        require(_allowances[from][msg.sender]>0, "You owe someone $" );
        require(value>0, "You have to send positive funds, bro" );
        require(_allowances[from][msg.sender]> value, "You aren't allowed to spend that much from their account" );
        require(_balanceOf[from]>value, "You don't have enough money");
        
            _allowances[from][msg.sender] = _allowances[from][msg.sender].sub(value);
            _balanceOf[from] = _balanceOf[from].sub(value);
            _balanceOf[to] = _balanceOf[to].add(value);
            
            return true;
        
    }
    
    function approve(address _spender, uint _value) public returns (bool success) {
        _allowances[msg.sender][_spender] = _value;
        return true;
    }
    
    function allowance(address _owner, address _spender) public view returns (uint remaining) {
        return _allowances[_owner][_spender];
    }
    
}