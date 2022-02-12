// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Lottery Contract
 * @dev Frankiefab100
 */
contract Lottery {

    uint MAX_PLAYERS = 10;
    address manager;
    address winner;
    address[] players;

    constructor(){
        manager = msg.sender;
    }

    function retrieveWinner() public view returns (address){
        return winner;
    }

    function retrievePlayers() public view returns (address[] memory){
        return players;
    }

    function result() public payable{
        require(players.length < MAX_PLAYERS);

        players.push(msg.sender);

        if (players.length == 10){
            selectWinner();
        }
    }

    function selectWinner() private {
        uint index = random() % players.length;
        winner = players[index];
        payable(players[index]).transfer(address(this).balance);
    }

    function random() private view returns (uint) {
        return uint (keccak256(abi.encodePacked(block.number, block.timestamp, players)));
    }
}