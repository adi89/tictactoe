require_relative 'functions'
require_relative 'board'
require_relative 'game_log'

class Game
  attr_reader :player1_symbol, :player2_symbol
  attr_accessor :moves, :board, :game_configuration

  def initialize(game_type, game_symbol)
    @game_type = game_type
    @board = Board.new
    @player1 = Player.new(valid_game_symbol(game_symbol))
    @player2 = Player.new(alternate_game_symbol)
    @board.draw
    @game_configuration = nil
    start_game
  end

  def start_game
    if @game_type == 'human'
      start_human_game
    else
      puts "Loading AI so you can't win. Hol'up! "
      @game_configuration ||= GameLog.new(self, @player1.game_symbol).populate
      start_computer_game
    end
  end


  def final_state?
    winner || draw
  end

  def winner
    #basically we check the board against the gamestate
    @game_configuration.slots
  end

  def update_game_board(active_player, position)
    index = (position.to_i - 1 )
    if @board.update_game_array(index, active_player)
      active_player.update_moves(position, self)
    end

    unless @game_type == 'human'
      @game_configuration = @game_configuration.potential_moves.select{|i| @board.game_array == i.slots}.first
    end
    @board.draw
  end

  def start_human_game

    position = valid_position_prompt
    active_player = whose_turn

    update_game_board(active_player, position)

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

    if @game_configuration.final_state?
      if game_configuration.draw
        puts "Draw"
        return
      elsif game_configuration.winner
        puts "#{game_configuration.winning_symbol} wins."
        return
      end
    end

    if @player1.game_symbol == @game_configuration.symbol
      position = valid_position_prompt
      active_player = whose_turn

      update_game_board(active_player, position)
      start_computer_game
    else
      @game_configuration = @game_configuration.minimax_move
      board.update_from_minimax_move(@game_configuration.slots)
      puts "Minimax Move"
      board.draw
      start_computer_game
      #computer move
    end

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
