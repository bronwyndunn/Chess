require_relative "cursor"
require "colorize"
require "byebug"
class Display

  attr_accessor :cursor, :board

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render(grid)
    cursor_pos = @cursor.cursor_pos
    8.times do |x|
      row_display = ""
      8.times do |y|
        character = grid[x][y].symbol
        if [x,y] == cursor_pos
          print row_display
          print character.colorize(:background => :light_blue)
          row_display = ""
        else
          row_display += character
        end
      end
      puts row_display
    end
    puts ""
    cursor.get_input
  end
end
