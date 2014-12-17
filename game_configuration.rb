require_relative 'game'

class GameConfiguration

  attr_accessor :potential_moves, :slots, :rank
  attr_reader :symbol, :winner

  def initialize(symbol = 'X', slots)
    @potential_moves = [] #other GameConfigs
    @symbol = symbol
    @slots = slots #board array
  end

  def minimax_move
    if symbol == 'X'
      potential_moves.max_by{|x| x.rank }
    else
      potential_moves.min_by{|x| x.rank }
    end
  end

  def rank
    @rank ||= (final_state || intermediary)
  end

  def final_state?
    (winner || draw)
  end

  def final_state
    if winner
      (winning_symbol == "X") ? 1 : -1
    elsif draw
      return 0
    else
      nil
    end
  end

  def intermediary
    rankings = potential_moves.map{|i| i.rank}
    if symbol == 'X'
      rankings.max
    else
      rankings.min
    end
  end

  def winner
    @winner ||= successful_array_configurations.map { |s_indexes|
      winning_conditional(s_indexes) || nil
    }.compact.first
  end

  def winning_symbol
    indexes = successful_array_configurations.select{|i| winning_conditional(i)}.flatten
    slots[indexes[0]]
  end


  def draw
    (slots.compact.size == 9) && (winner.nil?)
  end


private

  def winning_conditional(s_indexes)
    unless [ slots[s_indexes[0]], slots[s_indexes[1]], slots[s_indexes[2]] ].any?{|i| i.nil? }
      ( slots[s_indexes[0]] == slots[s_indexes[1]] ) && ( slots[s_indexes[0]] == slots[s_indexes[2]] ) &&
        ( slots[s_indexes[1]] == slots[s_indexes[2]])
    end
  end

  def successful_array_configurations
    [ [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 4, 8],
      [2, 4, 6],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
      ]
  end

end
