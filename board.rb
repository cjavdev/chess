class Board

  COL_HASH = {a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7}


  #EXAMPLE MOVE
  #pos= f4 #player enters postion
  #[(4-1), col_hash[f]]   reverse order, subtract one from
                          #row to match index, pull value from COL_HASH

  def initialize
    #calls generate board
  end


  private

  def generate_board
    board = []
    8.times do
      board << [nil] * 8
    end
  end
end

