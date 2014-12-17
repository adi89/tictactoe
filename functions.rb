require 'pry-debugger'
require_relative 'game'

# $board = {"1" => '_', "2" => '_', "3" => '_',
#           "4" => '_', "5" => '_', "6" => '_',
#           "7" => '_', "8" => '_', "9" => '_'}


#things that must happen
# enter position. it hits position and saves onto that position on the board. that position can no longer be chosen.
# iterate on move count
# after 3 total moves, we check whether there's a 3 in a row match. if we do , the game is over. and we

#to check if 3 in a row match, we have to determine that there's 3 in a row.
#we can have configurations of 3 in a row saved

# 1 2 3
# 4 5 6
# 7 8 9
# 1 4 7
# 2 5 8
# 3 6 9
# 1 5 9
# 7 5 3

# we'll select the array that have positions at that row.
def menu
  puts "Of all the computer games or videogames in the world, you've chosen to play Tic Tac Toe on Ruby. Good choice. Do You Want to Play:"
  puts  "a) Human v. Human"
  puts  "b) Human vs. Unbeatable Computer"
  response = gets.chomp.downcase
  puts "Would you like to be X or O ? "
  symbol = gets.chomp.upcase
  case response
  when 'a' then Game.new('human', symbol)
  when 'b' then Game.new('unbeatable', symbol)
  else menu
  end
end




