require 'set'
require 'debugger'
class Piece
  attr_accessor :location
  attr_reader :color, :board, :directions

  def initialize(starting_location, color, board)
    @location = starting_location
    @color = color
    @board = board
    @board.pos(@location).occupied_by = self

    # @board[@location] = self
    # Board#[]=
  end


  def valid_move?(position)
    possible_moves.include?(position)
  end

end

class Slider < Piece

  # def valid_move?(destination, delta)
  #   super(destination) && valid_path?(destination)
  # end

  def possible_moves
    possible_moves = []
    @directions.each do |dir|
      possible_moves += build_path(Square.deltas[dir])
    end
    possible_moves
  end

  def build_path(dir)
    path = []
    row_offset, col_offset = dir
    row, col = [@location[0] + row_offset, @location[1] + col_offset]
    while Square.in_board?([row, col])
      #debugger if [row, col] == [4,3]
      square_contents = @board.pos([row, col]).occupied_by


      if square_contents.nil? || square_contents.color != @color
        path << [row, col]
      end

      break unless square_contents.nil?

      row += row_offset
      col += col_offset
    end
    path
  end

end

class Stepper < Piece


end


# class Queen < Slider
#
#   def valid_move?(position)
#     DELTA = []
#     super(position, )
#   end
# end
# #etc...

class Rook < Slider

  def initialize(starting_location, color, board)
    super(starting_location, color, board)
    @directions = Set.new [:north, :south, :east, :west]
  end

end


class Pawn < Stepper
  def initialize(starting_location, color, board)
    super(starting_location, color, board)
    case @color
    when :black
      @directions = Set.new [:south, :se, :sw]
    when :white
      @directions = Set.new [:north, :ne, :nw]
    end
  end
end
