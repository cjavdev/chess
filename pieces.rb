class Piece
  attr_accessor :location
  attr_reader :color, :board

  def initalize(starting_location, color, board)
    @location = starting_location
    @color = color
    @board = board
  end


  def valid_move?(position)
    #checks for a piece of the same color in given space then gives to child class
    !@board.position_contains?(@color)

  end
end

class Sliders < Piece

  # def valid_move?(position, delta)
 #    if super(position)
 #
 #
 #    else
 #      return false
 #    end
 #  end

  def valid_path?(position)
    intermediates = build_path(position)
    intermediates.none? do |square|
      valid_move?(square) == false
    end
  end

  def build_path(position)
    # returns an array of all squares between location and position
  end

end


class Steppers < Piece


end


class Queen < Slider

  def valid_move?(position)
    DELTA = []
    super(position, )
  end
end
#etc...



class Pawn < Steppers


end
