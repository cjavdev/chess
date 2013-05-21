class Board

  COL_HASH = {a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7}


  #EXAMPLE MOVE
  #pos= f4 #player enters postion
  #[(4-1), col_hash[f]]   reverse order, subtract one from
                          #row to match index, pull value from COL_HASH

  def initialize
    @board = generate_board
  end


  private

  def generate_board
    board = []
    8.times do |row_index|
      board << []
      8.times do |column_index|
        board[row_index] << Square.new([row_index, column_index])
      end
    end
    board.each do |row|
      row.each do |square|
        square.set_neighbors
      end
    end
    board
  end
end


class Square
  attr_accessor :neighbors, :occupied
  attr_reader :north, :south, :east, :west, :nw, :sw, :ne, :se, :location
  alias_method :occupied?, :occupied

  def initialize(location)
    @location = location
    @east = nil
    @west = nil
    @north = nil
    @south = nil
    @ne = nil
    @sw = nil
    @se = nil
    @nw = nil

  end

  def set_neighbors
    row, column  = @location
    @south = [(row+1), column] if is_in_board?([(row+1), column])
    @north = [(row-1), column] if is_in_board?([(row-1), column])
    @east = [row, column+1] if is_in_board?([row, column+1])
    @west = [row, column-1] if is_in_board?([row, column-1])
    @se = [(row+1), column+1] if is_in_board?([(row+1), column+1])
    @nw = [(row-1), column-1] if is_in_board?([(row-1), column-1])
    @ne = [(row-1), column+1] if is_in_board?([(row-1), column+1])
    @sw = [(row+1), column-1] if is_in_board?([(row+1), column-1])
  end

  def is_in_board?(coord)
    coord.all? {|c| c.between?(0, 7)}
  end

end
