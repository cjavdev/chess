class Board
  attr_reader :board
  COL_HASH = {a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7}


  #EXAMPLE MOVE
  #pos= f4 #player enters postion
  #[(4-1), col_hash[f]]   reverse order, subtract one from
                          #row to match index, pull value from COL_HASH

  def initialize
    @board = generate_board
  end

  def pos(position)
    row, col = position

    @board[row][col]
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
  DELTAS = {
    :south => [1, 0],
    :north => [-1, 0],
    :east => [0, 1],
    :west => [0, -1],
    :se => [1, 1],
    :nw => [-1, -1],
    :ne => [-1, 1],
    :sw => [1, -1]
  }

  attr_accessor :occupied
  attr_reader :location, :neighbors
  alias_method :occupied?, :occupied

  def initialize(location)
    @location = location
    @neighbors = Hash.new { nil }
  end

  def set_neighbors
    row, col  = @location

    DELTAS.each do |key, value|
      new_row = value[0] + row
      new_col = value[1] + col

      if in_board? ([new_row, new_col])
        @neighbors[key] = [new_row, new_col]
      end
    end
  end

  def in_board?(coord)
    coord.all? {|c| c.between?(0, 7)}
  end

end
