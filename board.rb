require_relative 'game'
require_relative 'player'

class Board

  attr_accessor :available_positions, :moves, :game_array

  def initialize
    @positions = position_hash
    @available_positions = (1..9).to_a
    @moves = 0
    @game_array = Array.new(9)
  end

  def draw
    puts ""
    puts "#{@positions['1']} | #{@positions["2"]} | #{@positions["3"]}    #{available_position_display(('1'..'3').to_a)}"
    puts "#{@positions['4']} | #{@positions["5"]} | #{@positions["6"]}    #{available_position_display(('4'..'6').to_a)}"
    puts "#{@positions['7']} | #{@positions["8"]} | #{@positions["9"]}    #{available_position_display(('7'..'9').to_a)}"
  end

  def successful_configurations
    [[1, 2, 3],
     [4, 5, 6],
     [7, 8, 9],
     [1, 4, 7],
     [2, 5, 8],
     [3, 6, 9],
     [1, 5, 9],
     [3, 5, 7]
     ]
  end

  def update_game_array(index, player)
    @game_array[index] = player.game_symbol
    update_board(player.game_symbol, (index + 1).to_s)
  end

  def update_from_minimax_move(game_config_slots)
    # symbol = (game_config_slots - @game_array).first
    symbol, index = game_config_differs_at(game_config_slots)
    @game_array[index] = symbol
    update_board(symbol, (index + 1).to_s)
  end

  def game_config_differs_at(game_config_slots)
   game_config_slots.each_with_index do |element, index|
      if @game_array[index] != element
        return element, index
      end
    end
  end


  def update_board(symbol, position)
    raise "Enter Available Position" if @available_positions.include? position
    @available_positions.delete(position.to_i)
    @moves += 1
    @positions[position] = symbol
  end

  private

  def available_position_display(keys)
    string = ''
    keys.each do |key|
      string += if @positions[key] == '_'
        key
      else
        '_'
      end
    end
    string
  end

  def position_hash
    {"1" => '_', "2" => '_', "3" => '_',
     "4" => '_', "5" => '_', "6" => '_',
     "7" => '_', "8" => '_', "9" => '_'}
  end

end
