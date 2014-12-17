require_relative 'game'
require_relative 'game_configuration'
require 'pry-debugger'

class GameLog

  attr_reader :state_tree

  def initialize(game, player1)
    @game = game
    @state_tree = GameConfiguration.new(player1 , Array.new(9))
  end

  def populate
    branch_out(@state_tree)
    @state_tree
  end

  def branch_out(game_config)
    next_player = (game_config.symbol == 'X' ? 'O' : 'X')
    game_config.slots.each_with_index do |move, index|
      unless move
        next_game_slot = game_config.slots.dup
        next_game_slot[index] = game_config.symbol
        next_game_config =  GameConfiguration.new(next_player, next_game_slot)
        game_config.potential_moves << next_game_config
        branch_out(next_game_config)
      end
    end
  end

end
