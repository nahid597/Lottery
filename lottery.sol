pragma solidity ^0.6.4;

contract Lottery{
    address public owner;
    address payable[] public players;

    constructor() public{
        owner = msg.sender;
    }

    modifier OwnerOnly
    {
        if(msg.sender == owner)
        {
            _;
        }
    }

    function cutLottery() public payable{
        if(msg.value >= 1 ether)
        {
            players.push(msg.sender);
        }
    }

    function GenerateRandomNumber() private view returns(uint)
    {
       return uint (keccak256(abi.encodePacked(block.difficulty, players.length)));
    }

    function PicWinner() public OwnerOnly
    {
        uint RandomNum = GenerateRandomNumber();
        uint index = RandomNum % players.length;
        address payable winner;

        winner = players[index];
        winner.transfer(address(this).balance);

        players = new address payable[](0);

    }


}