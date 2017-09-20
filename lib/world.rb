#for the world
class World
  attr_accessor :rows, :columns, :cell_grid, :cells

  def initialize(rows=3,columns=3)
    @rows = rows
    @columns = columns
    @cells = []
    @cell_grid = Array.new(rows) do |row|
                   Array.new(columns) do |column|
                     cell = Cell.new(row,column)
                     cells << cell
                     cell
                   end
                 end
  end

  #find out neighbours of the cell
  def live_neighbours_around_cell(cell)
    live_neighbours = []

    #check top cell
    if cell.x_axis > 0
      # puts "Cell dimen1: #{cell.x_axis}:#{cell.y_axis}"
      candidate = self.cell_grid[cell.x_axis - 1][cell.y_axis]
      # puts "Candidate #{candidate.inspect}"
      live_neighbours << candidate if candidate.alive?
    end
    #check right cell
    if cell.y_axis < (columns-1)
      # puts "Cell dimen2: #{cell.x_axis}:#{cell.y_axis}"
      candidate = self.cell_grid[cell.x_axis][cell.y_axis + 1]
      # puts "Candidate #{candidate.inspect}"
      live_neighbours << candidate if candidate.alive?
    end
    #check left cell
    if cell.y_axis > 0
      # puts "Cell dimen3: #{cell.x_axis}:#{cell.y_axis}"
      candidate = self.cell_grid[cell.x_axis][cell.y_axis - 1]
      # puts "Candidate #{candidate.inspect}"
      live_neighbours << candidate if candidate.alive?
    end
    # #check bottom cell
    if cell.x_axis < (rows-1)
      # puts "Cell dimen4: #{cell.x_axis}:#{cell.y_axis}"
      candidate = self.cell_grid[cell.x_axis + 1][cell.y_axis]
      # puts "Candidate #{candidate.inspect}"
      live_neighbours << candidate if candidate.alive?
    end
    # #check top left
    if cell.x_axis > 0 and cell.y_axis > 0
      # puts "Cell dimen5: #{cell.x_axis}:#{cell.y_axis}"
      candidate = self.cell_grid[cell.x_axis - 1][cell.y_axis - 1]
      # puts "Candidate #{candidate.inspect}"
      live_neighbours << candidate if candidate.alive?
    end
    # #check top right
    if cell.x_axis > 0 and cell.y_axis < (columns-1)
      # puts "Cell dimen6: #{cell.x_axis}:#{cell.y_axis}"
      candidate = self.cell_grid[cell.x_axis - 1][cell.y_axis + 1]
      # puts "Candidate #{candidate.inspect}"
      live_neighbours << candidate if candidate.alive?
    end
    # #check bottom left
    if cell.x_axis < (rows - 1) and cell.y_axis > 0
      # puts "Cell dimen7: #{cell.x_axis}:#{cell.y_axis}"
      candidate = self.cell_grid[cell.x_axis + 1][cell.y_axis - 1]
      # puts "Candidate #{candidate.inspect}"
      live_neighbours << candidate if candidate.alive?
    end
    # #check bottom right
    if cell.x_axis < (rows - 1) and cell.y_axis < (columns - 1)
      # puts "Cell dimen8: #{cell.x_axis}:#{cell.y_axis}"
      candidate = self.cell_grid[cell.x_axis + 1][cell.y_axis + 1]
      # puts "Candidate #{candidate.inspect}"
      live_neighbours << candidate if candidate.alive?
    end
    live_neighbours
  end
end