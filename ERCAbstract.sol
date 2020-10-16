import "./Ownable.sol";
pragma solidity 0.5.12;


   contract ERC20 is Ownable{
       
    
    function name() public view returns (string memory) {
    }

    function symbol() public view returns (string memory) {
    }

    function decimals() public view returns (uint8) {
    }

    function totalSupply() public view returns (uint256) {
    }
    function balanceOf(address account) public view onlyOwner returns (uint256) {
    }

    function mint(address account, uint256 amount) public onlyOwner{
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {

    }
    
   } 