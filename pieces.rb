require 'set'
require 'debugger'
class Piece
  DELTAS = {
    :south => [1, 0],
    :north => [-1, 0],
    :east => [0, 1],
    :west => [0, -1],
    :se => [1, 1],
    :nw => [-1, -1],
    :ne => [-1, 1],
    :sw => [1, -1],
    :nne => [-2, 1],
    :nnw => [-2, -1],
    :een => [-1, 2],
    :ees => [1, 2],
    :sse => [2, 1],
    :ssw => [2, -1],
    :wwn => [-1, -2],
    :wws => [1, -2]
  }

  attr_accessor :location
  attr_reader :color, :board, :directions

  def initialize(starting_location, color, board)
    @location = starting_location
    @color = color
    @board = board
    @board[*@location] = self #stand in for testing, occupied_by no longer exists

  end


  def valid_move?(position)
    possible_moves.include?(position)
  end

  def possible_moves
    possible_moves = []
    @directions.each do |dir|
      #debugger
      possible_moves += build_path(DELTAS[dir])
    end
    possible_moves
  end

  def build_path(dir)
    path = []
    row_offset, col_offset = dir
    row, col = [@location[0] + row_offset, @location[1] + col_offset]
    while Board.in_board?([row, col])
      square_contents = @board[row, col]

      if square_contents.nil? || square_contents.color != @color
        path << [row, col]
      end

      break unless square_contents.nil?
      break if self.is_a?(Stepper)
      row += row_offset
      col += col_offset
    end
    path
  end

end

class Slider < Piece

end

class Stepper < Piece

end


class Queen < Slider

  def initialize(starting_location, color, board)
    super(starting_location, color, board)
    @directions = Set.new [:north, :south, :east, :west, :se, :ne, :sw, :se]
  end

end


class Rook < Slider

  def initialize(starting_location, color, board)
    super(starting_location, color, board)
    @directions = Set.new [:north, :south, :east, :west]
  end

end


class Bishop < Slider

  def initialize(starting_location, color, board)
    super(starting_location, color, board)
    @directions = Set.new [:ne, :se, :nw, :sw]
  end

end


class King < Stepper

  def initialize(starting_location, color, board)
    super(starting_location, color, board)
    @directions = Set.new [:north, :south, :east, :west, :se, :ne, :sw, :sw]
  end

end

class Pawn < Stepper
  def initialize(starting_location, color, board)
    super(starting_location, color, board)
    case @color
    when :black
      @directions = Set.new [:south]
    when :white
      @directions = Set.new [:north]
    end
  end
end


class Knight < Stepper
  def initialize(starting_location, color, board)
    super(starting_location, color, board)
    @directions = Set.new [:nne, :nnw, :een, :ees, :sse, :ssw, :wwn, :wws]
  end
end