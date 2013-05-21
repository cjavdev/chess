class Piece
  attr_accessor :location
  attr_reader :color

  def initalize(starting_location, color)
    @location = starting_location
    @color = color
  end

end


class Pawn < Piece

  def initialize(starting_location, color)
    super(starting_location, color)
  end
end


#etc...