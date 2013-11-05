GoFish
======

Ruby implementation of card game Go Fish!

The Game
--------

Go Fish! is a simple card game.

Basically, there's a 52-card deck and each player (in this case a user and a computer) gets 7 cards each.

The game is playing in the following way:

* A player asks the other for a rank (2-10, J, Q, K, A)
  * If the other player has one or more cards with the same rank, then he hands them over to the requester
  * If the other player has no cards with the same rank, then the requester must take one card from the deck
   When the player receives or draws a card he must check for pairs of cards with the same rank, if he has got any he must discard them
* The game continues until either the deck is empty, or any of the players has no more cards
* The player that has more pairs wins the game

> Play the game for more than you can afford to lose... only then will you learn the game.
> Winston Churchill
