#class for cells inside the world
class Cell
  attr_accessor :x_axis, :y_axis, :alive

  def initialize(x_axis=0, y_axis=0)
    @x_axis = x_axis
    @y_axis = y_axis
    @alive = false
  end
end