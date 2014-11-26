require 'pry-debugger'
require_relative 'game'

class Player

  attr_reader :game_symbol
  attr_accessor :winner

  def initialize(game_symbol)
    @game_symbol = game_symbol
    @positions = []
    @winner = false
  end

  def moves
    @positions.count
  end

  def sorted_positions
    @positions.sort
  end


  def update_moves(position, game)
    @positions << position.to_i
    if self.moves >= 3
      determine_match_result(game.board)
    end
  end

  def determine_match_result(board)
    if board.successful_configurations.include? trio_config
      self.winner = true
    end
  end

  def trio_config
    array = []
    sorted_positions.each_with_index do |integer, index|
      if sorted_positions[index + 2]
        array.push(integer, sorted_positions[index + 1], sorted_positions[index + 2])
      end
    end
    array
  end





end
