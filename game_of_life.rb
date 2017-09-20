require 'gosu'
require_relative 'lib/game'


class GameOfLifeWindow < Gosu::Window
  def initialize(height=600,width=400)
    @height = height
    @width = width
    super @height, @width, false
    self.caption = "Game Of Life"

    @background_colour = Gosu::Color.new(0xffdedede)
    @alive_color = Gosu::Color.new(0xff121212)
    @dead_color = Gosu::Color.new(0xffededed)

    @gosu_columns = @width/10
    @gosu_rows = @height/10
    @col_width = @width/@gosu_columns
    @row_height = @height/@gosu_rows

    @world = World.new(@gosu_columns,@gosu_rows)
    @game = Game.new(@world)
    @game.world.randomly_populate
  end

  def update
    @game.next_life_span!
  end

  def draw
    draw_quad( 0,0,@background_colour,
               @width,0,@background_colour,
               @width,@height,@background_colour,
               0,@height,@background_colour)

    @game.world.cells.each do |cell|
      if cell.alive?
        draw_quad(cell.y_axis * @col_width,cell.x_axis * @row_height, @alive_color,
                  cell.y_axis * @col_width + @col_width,cell.x_axis * @row_height, @alive_color,
                  cell.y_axis * @col_width + @col_width,cell.x_axis * @row_height + @row_height, @alive_color,
                  cell.y_axis * @col_width,cell.x_axis * @row_height + @row_height, @alive_color)
      else
        draw_quad(cell.y_axis * @col_width,cell.x_axis * @row_height, @dead_color,
                  cell.y_axis * @col_width + @col_width,cell.x_axis * @row_height, @dead_color,
                  cell.y_axis * @col_width + @col_width,cell.x_axis * @row_height + @row_height, @dead_color,
                  cell.y_axis * @col_width,cell.x_axis * @row_height + @row_height, @dead_color)
      end
    end
  end

  def need_cursor?
    true
  end
end

GameOfLifeWindow.new.show