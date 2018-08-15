pragma solidity ^0.4.17;

//currently string is treated as array and nested array is not supported in Web3,
//so array of strings is not supported in Web3

contract Lottery {
    address public manager;
    address[] public players;
    
    function Lottery() public {
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > .01 ether);
        
        players.push(msg.sender);
    }
    
    //there is currently no random number generator supported in solidity
    function random() private view returns (uint) {
        return uint(sha3(block.difficulty, now, players));
    }
    
    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(this.balance); //sending total value inside this contract to the player
        players = new address[](0); //flush out all players
    }
    
    modifier restricted() { //function modifier is for reducing code duplication
        require(msg.sender == manager); //validation
        _; //executing the rest of function code
    }
    
    //for returning full array because the function created by default for array variables 
    //will only return a single instance with a given index
    function getPlayers() public view returns (address[]) {
        return players;
    }
}