// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract game {

    uint256[] deck = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 , 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23 ,24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52];
    
    uint private amountOfPlayers;
    uint[] results;

    constructor(uint _amountOfPlayers) {
        amountOfPlayers = _amountOfPlayers;
        results = new uint256[](_amountOfPlayers);
    }


    function playRound() public {
        require(deck.length >= amountOfPlayers, "Not enough cards in deck.");

        uint _roundHighest = 0;
        uint _roundHighestPlayer;

        uint _playerCard;

        for(uint i = 0; i < amountOfPlayers; i ++) {
           _playerCard = getRandomCard();

           if (_playerCard >= _roundHighest) {
               _roundHighest = _playerCard;
               _roundHighestPlayer = i;
           }
        }

        results[_roundHighestPlayer]++;

    }

    function getRandomCard() public returns(uint) {
        uint pos = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % deck.length;
        uint card = deck[pos];

        removeCardFromDeck(pos);

        return card;
    }

    function removeCardFromDeck(uint _pos) public {

        deck[_pos] = deck[deck.length - 1];
        deck.pop();

    }

    function restartGame() public {
        deck = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 , 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23 ,24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52];
    }

    function returnDeck() public view returns(uint[] memory) {
        return deck;
    }

    function returnScore() public view returns(uint[] memory) {
        return results;
    }

}