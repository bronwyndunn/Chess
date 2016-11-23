require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
  include Slideable



  def set_symbol
    sym= "♕" if @color == :white
    sym = "♛" if @color == :black
    sym
  end
  def move_dirs
    [:horizontal, :diagonal]
  end

end
