#class to access from outside and control other classes
class Game
  attr_accessor :world

  def initialize(world=World.new,seeds=[])
    @world = world
    @seeds = seeds
    seeds.each do |seed|
      @world.cell_grid[seed[0]][seed[1]].alive = true
    end
  end

  #create the next life with game of life rules
  def next_life_span!
    next_round_dead_cells = []
    next_round_live_cells = []

    world.cells.each do |cell|
      #under population rule
      # puts cell.inspect
      # puts world.live_neighbours_around_cell(cell).count
      if cell.alive? and world.live_neighbours_around_cell(cell).count < 2
        next_round_dead_cells << cell
      end
      #cell to next gen
      if cell.alive? and ([2,3].include? world.live_neighbours_around_cell(cell).count)
        next_round_live_cells << cell
      end
      #over population
      if cell.alive? and world.live_neighbours_around_cell(cell).count > 3
        next_round_dead_cells << cell
      end
      #reproduction
      if cell.dead? and world.live_neighbours_around_cell(cell).count == 3
        next_round_live_cells << cell
      end
    end
    #revive cells for next span
    next_round_live_cells.each do |cell|
      cell.revive!
    end
    #kill cells
    next_round_dead_cells.each do |cell|
      cell.die!
    end
  end
end
