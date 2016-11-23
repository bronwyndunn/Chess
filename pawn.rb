require_relative "piece"
class Pawn < Piece

  def set_symbol
    sym = "♙" if @color == :white
    sym = "♟" if @color == :black
    sym
  end

  def moves(board)
    @board = board
    moves = []
    if @color == :white
      forward_move = [@position.first+1, @position.last]
      moves << forward_move if @board[forward_move].class == NilPiece

      double_jump = [@position.first+2, @position.last]
      moves << double_jump if @position.first == 1 &&
                board[double_jump].class == NilPiece
      [[1,-1], [1,1]].each do |pos|
        diag_move = [@position.first+pos.first, @position.last+pos.last]
        if @board.in_bounds?(diag_move)
          moves << diag_move if @board[diag_move].color == :black
        end
      end
    else
      forward_move = [@position.first-1, @position.last]
      moves << forward_move if @board[forward_move].class == NilPiece
      moves << [@position.first-2, @position.last] if @position.first == 6
      [[-1,1], [-1,-1]].each do |pos|
        diag_move = [@position.first+pos.first, @position.last+pos.last]
        if @board.in_bounds?(diag_move)
          moves << diag_move if @board[diag_move].color == :white
        end
      end
    end
    moves
  end
end
