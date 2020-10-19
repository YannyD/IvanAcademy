import "./Ownable.sol";
import "./ERCAbstract.sol";
import "./SafeMath.sol";
pragma solidity 0.5.12;

contract YanCoin is ERC20{
    
    using SafeMath for uint256;
    
    string private constant _symbol = "YCN";
    string private constant _name = "YanCoin";
    uint8 private constant _decimals = 18;
    uint private  __totalSupply = 1000000;
    
    mapping(address=>uint) private _balanceOf;
    mapping(address=> mapping(address=>uint)) private _allowances;
    
    constructor() public{
        _balanceOf[msg.sender]= __totalSupply;
    }
    
    function name() public view returns (string memory){
        return _name;
    }
    
     function symbol() public view returns (string memory) {
         return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }
    
    function mint(address account, uint256 amount) public onlyOwner{
       //How do we read the .add --> is it like js pass through?
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
    
    //what is the give and take between if else and requires?  Just error messages?
    function transfer(address _to, uint _value) public returns (bool success){
        if(_value> 0 && _value <=balanceOf(msg.sender)){
            _balanceOf[msg.sender] = _balanceOf[msg.sender].sub(_value);
            _balanceOf[_to] = _balanceOf[_to].add(_value);
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
            
            _allowances[from][msg.sender] = _allowances[from][msg.sender].sub(value);
            _balanceOf[from] = _balanceOf[from].sub(value);
            _balanceOf[to] = _balanceOf[to].add(value);
            
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