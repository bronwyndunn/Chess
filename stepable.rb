module Stepable
  def moves(board)
    @board = board
    moves = []
    directions = move_dirs
    directions.each do |direction|
      case direction
      when :king
        king_moves = [[1,1], [1,0], [1,-1],[0,-1], [-1,-1], [-1,0], [-1,1], [0,1]]
        king_moves.each do |move|
          moves << [@position.first+move.first, @position.last+move.last]
        end
      when :knight
        knight_moves = [[1,2], [2,1], [1,-2], [2,-1], [-1,-2], [-2,-1], [-1,2], [-2,1]]
        knight_moves.each do |move|
          moves << [@position.first+move.first, @position.last+move.last]
        end
      end
      moves = moves.select do |move|
        @board.in_bounds?(move) && @board[move].color != @color
      end
    end
    moves
  end
end
