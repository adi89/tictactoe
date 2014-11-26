require_relative 'functions'
require_relative 'board'

class Game
  attr_reader :player1_symbol, :player2_symbol
  attr_accessor :moves, :board

  def initialize(game_type, game_symbol)
    @game_type = game_type
    @board = Board.new
    @player1 = Player.new(valid_game_symbol(game_symbol))
    @player2 = Player.new(alternate_game_symbol)
    @board.draw
    start_game
  end

  def start_game
    if @game_type == 'human'
      start_human_game
    else
      start_computer_game
    end
  end

  def start_human_game

    position = valid_position_prompt
    active_player = whose_turn

    if @board.update_board(active_player, position)
      active_player.update_moves(position, self)
    end
    @board.draw

    if active_player.winner == true
      puts "Player #{active_player.game_symbol} won!!"
    else
      if @board.available_positions.count > 0
        start_human_game
      else
        puts "Game was a Draw!"
      end
    end
  end


  def start_computer_game

  end

  private

  def valid_position_condition(position)
    int_position = position.to_i
    int_position.is_a?(Integer) && (@board.available_positions.include?(int_position))
  end

  def valid_position_prompt
    puts "Enter position for #{whose_turn.game_symbol}"
    position = gets.chomp
    if valid_position_condition(position)
      position
    else
      puts "Enter valid position!"
      valid_position_prompt
    end
  end

  def whose_turn
    @board.moves.even? ? @player1 : @player2
  end

  def valid_game_symbol(game_symbol)
    ['X', 'O'].include?(game_symbol) ? game_symbol : 'X'
  end

  def alternate_game_symbol
    (@player1.game_symbol.upcase == 'X') ? 'O' : 'X'
  end


end
