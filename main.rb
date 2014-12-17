# "We have sample project in mind because we are eager to see how you code-- an unbeatable TicTacToe.

#  It is both a great opportunity to show off your strength with algorithms, and a way to demonstrate good coding practices.

# In the language of your choice, please create the unbeatable TicTacToe with the following rules:

# 1) It can be played Human vs. Human, Human vs. AI, AI vs. Human
# 2) The AI must be completely unbeatable. Draws are fine.
# 3) It shouldn't crash and should be used as an opportunity to show off how well you can write software
# 4) Please provide instructions to run the application"

require_relative 'functions'





menu


# when player a enters X

#then the board will have the game state of the

# X | |
#   | |
#   | |

#basically when the player enters at the position, we searcht he existing gamestates and then we see the different potential gamestates. let's start w/ that.

# i want a basic function that will determine the active player (human or not). and based on that call upon human move or


#pure accessing game states, and selecitng the right one.
# determining final state? or if the game has a winner. easy to do w/ the board
# keep updating board even as you access the game's next state  ( HOW ?
#make a mechanism for by you look at your previous game_state, it updates position w/ new gamestate.
#basically update the game array. # you also can figure out the move and the game array from there. find out what index is different in the new array. then use that info to update the game array

#then take care of minimax.
