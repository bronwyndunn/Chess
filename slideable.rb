require "byebug"
module Slideable

  def moves(board)
    @board = board
    places = []
    directions = move_dirs
    directions.each do |direction|
      case direction
      when :diagonal
        places += get_diagonal_moves
      when :horizontal
        places += get_horizontal_moves
      end
    end
    places
  end

  def get_horizontal_moves
    places = []
    left_moves = []
    right_moves = []
    up_moves = []
    down_moves = []
    (0...@position[1]).to_a.reverse.each do |y|
      left_moves << [@position.first,y]
    end
    ((@position[1] + 1)..7).to_a.each do |y|
      right_moves << [@position.first,y]
    end
    (0...@position[0]).to_a.reverse.each do |x|
      up_moves << [x, @position.last]
    end
    ((@position[0]+1)..7).each do |x|
      down_moves << [x, @position.last]
    end
    moves = [left_moves,right_moves, up_moves, down_moves]
    moves.each do |directions|
      directions.each do |pos|
        if @board[pos].class == NilPiece
          places << @board[pos].position
        else
          if @board[pos].color != @color
            places << @board[pos].position
          end
          break
        end
      end
    end
    places
  end

  def get_diagonal_moves
    places = []
    up_left = []
    up_right = []
    down_left = []
    down_right = []
    up_left_pos = [@position.first-1, @position.last-1]
    while @board.in_bounds?(up_left_pos)
      up_left << up_left_pos
      up_left_pos = [up_left_pos.first-1, up_left_pos.last-1]
    end

    up_right_pos = [@position.first-1, @position.last+1]
    while @board.in_bounds?(up_right_pos)
      up_right << up_right_pos
      up_right_pos = [up_right_pos.first-1, up_right_pos.last-1]
    end

    down_left_pos = [@position.first+1, @position.last-1]
    while @board.in_bounds?(down_left_pos)
      down_left << down_left_pos
      down_left_pos = [down_left_pos.first+1, down_left_pos.last-1]
    end

    down_right_pos = [@position.first+1, @position.last+1]
    while @board.in_bounds?(down_right_pos)
      down_right << down_right_pos
      down_right_pos = [down_right_pos.first+1, down_right_pos.last+1]
    end
    moves = up_left + up_right + down_left + down_right
    moves.each do |pos|
      if @board[pos].class == NilPiece
        places << @board[pos].position
      else
        if @board[pos].color != @color
          places << @board[pos].position
        end
        break
      end
    end

  places
  end


end
