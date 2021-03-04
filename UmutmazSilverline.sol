pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
contract UmutmazSilverline is IERC20{
    
    uint256 private _totalHairLine = 100000;
    string private _name = "Umutmaz Silverline Token";
    string private _symbol = "USL";
    uint8 private _decimals;
    address private _owner;
    mapping (address => uint256) private _hairLineLeft;
    mapping (address => mapping (address => uint256)) private _tolerances;

    
    constructor()  {
        _owner = msg.sender;
        _hairLineLeft[msg.sender]=_totalHairLine;
        emit Transfer(address(0), msg.sender, _totalHairLine);
    }
    
    function totalSupply() public view  virtual override returns (uint){
        return _totalHairLine - _hairLineLeft[address(0)];
    }
    
    function balanceOf(address _address) public view  virtual override returns (uint balance){
        return _hairLineLeft[_address];
    }
    
     function allowance(address _ownerAddress, address _spenderAddress)public view  virtual override returns(uint256){
        return _tolerances[_ownerAddress][_spenderAddress];
    }
     function approve(address _spender, uint _hairLines)public virtual override returns (bool success){
        _tolerances[msg.sender][_spender]=_hairLines;
        emit Approval(msg.sender, _spender, _hairLines);
        return true;
    }
     function transfer(address _to, uint _hairLines)public  virtual override returns(bool success){
        require(msg.sender==_owner, "Invalid operation, use transferFrom to do it");
        require(_hairLines<_hairLineLeft[msg.sender], "No more hairline left in the token owner, keep it chill bro");
        _hairLineLeft[msg.sender]-=_hairLines ;
        _hairLineLeft[_to]+=_hairLines;
        emit Transfer(msg.sender,_to, _hairLines);
        return true;
    }
     function transferFrom(address _from, address _to, uint _hairLines) public  virtual override returns (bool success) {
        require(_hairLines<_hairLineLeft[_from], "No more hairline left in the token owner, keep it chill bro");
        _hairLineLeft[_from] -= _hairLines;
        _tolerances[_from][msg.sender] -= _hairLines;
        _hairLineLeft[_to] += _hairLines ;
        emit Transfer(_from, _to, _hairLines);
        return true;
    }
    
    
}
