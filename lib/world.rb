#for the world
class World
  attr_accessor :rows, :columns, :cell_grid

  def initialize(rows=3,columns=3)
    @rows = rows
    @columns = columns
    @cells = []
    @cell_grid = Array.new(rows) do |row|
                   Array.new(columns) do |column|
                     Cell.new(row,column)
                   end
                 end
  end
end