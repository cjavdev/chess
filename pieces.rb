require 'set'

class Piece
  attr_accessor :location
  attr_reader :color, :board, :directions

  def initialize(starting_location, color, board)
    @location = starting_location
    @color = color
    @board = board
  end


  def valid_move?(position)
    #checks for a piece of the same color in given space then gives to child class
    !@board.position_contains?(@color)

  end
end

class Slider < Piece

  # def initialize(starting_position, color, board)
  #   super(starting_position, color, board)
  # end

  def valid_move?(position, delta)
    super(position) && valid_path?(position)
  end

  def valid_path?(position)
    intermediates = build_path(position)
    intermediates[0...-1].none? do |square|
      @board.pos(square).occupied?
    end
  end

  def build_path(position)
    # returns an array of all square coordinates between location and position
  end

  def move
    @directions.each do |d|
      puts d
    end
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


end
