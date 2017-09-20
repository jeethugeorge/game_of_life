#Test Cases using Rspec
require 'rspec'

require_relative '../lib/game'
require_relative '../lib/world'
require_relative '../lib/cell'


describe "the game of life" do

  let!(:world) { World.new }
  let!(:cell) { Cell.new(1, 1)}
  let!(:game) { Game.new }

  context 'World' do

    it 'should create a new world object' do
      expect(world.is_a?(World)).to be_truthy
    end

    it "should respond to proper methods" do
      expect(world).to respond_to(:rows, :columns, :cell_grid)
    end

    it "should return proper cell grid" do
      expect(world.cell_grid.is_a?(Array)).to be_truthy
      world.cell_grid.each do |row|
        expect(row.is_a?(Array)).to be_truthy
        row.each do |col|
          expect(col.is_a?(Cell)).to be_truthy
        end
      end
    end

    it "should detect neighbour to top" do
      world.cell_grid[cell.x_axis-1][cell.y_axis].alive = true
      expect(world.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it "should detect neighbour to right" do
      world.cell_grid[cell.x_axis][cell.y_axis + 1].alive = true
      expect(world.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it "should detect neighbour to left" do
      world.cell_grid[cell.x_axis][cell.y_axis - 1].alive = true
      expect(world.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it "should detect neighbour to bottom" do
      world.cell_grid[cell.x_axis + 1][cell.y_axis].alive = true
      expect(world.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it "should detect neighbour to top left" do
      world.cell_grid[cell.x_axis - 1][cell.y_axis - 1].alive = true
      expect(world.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it "should detect neighbour to top right" do
      world.cell_grid[cell.x_axis - 1][cell.y_axis + 1].alive = true
      expect(world.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it "should detect neighbour to bottom left" do
      world.cell_grid[cell.x_axis + 1][cell.y_axis - 1].alive = true
      expect(world.live_neighbours_around_cell(cell).count).to eq(1)
    end

    it "should detect neighbour to bottom right" do
      world.cell_grid[cell.x_axis + 1][cell.y_axis + 1].alive = true
      expect(world.live_neighbours_around_cell(cell).count).to eq(1)
    end
  end

  context "Cell" do

    subject { Cell.new }

    it "should create a new cell object" do
      expect(subject.is_a?(Cell)).to be_truthy
    end

    it "should respond to proper methods" do
      expect(subject).to respond_to(:alive, :x_axis, :y_axis)
    end

    it "should initialize properly" do
      expect(subject.alive).to be_falsey
      expect(subject.x_axis).to eq(0)
      expect(subject.y_axis).to eq(0)
    end
  end

  context "Game" do

    subject { Game.new }

    it "should create a new game object" do
      expect(subject.is_a?(Game)).to be_truthy
    end

    it "should respond to proper methods" do
      expect(subject).to respond_to(:world)
    end

    it "should initialize properly" do
      expect(subject.world.is_a?(World)).to be_truthy
    end

    context "Rule 1: under population" do

      it "should kill a live cell with no neighbours" do
        game.world.cell_grid[2][1].alive = true
        expect(game.world.cell_grid[2][1]).to be_alive
        game.next_life_span!
        expect(game.world.cell_grid[1][1]).to be_dead
      end

      it "should kill a live cell with 1 neighbours" do
        game.world.cell_grid[1][0].alive = true
        game.world.cell_grid[2][0].alive = true
        game.next_life_span!
        expect(game.world.cell_grid[1][0]).to be_dead
        expect(game.world.cell_grid[2][0]).to be_dead
      end

      it "should not kill a live cell with 2 neighbours" do
        game = Game.new(world,[[0,1],[1,1],[2,1]])
        expect(world.live_neighbours_around_cell(cell).count).to eq(2)
        game.next_life_span!
        expect(game.world.cell_grid[0][1]).to be_dead
        expect(game.world.cell_grid[2][1]).to be_dead
        expect(game.world.cell_grid[1][1]).to be_alive
      end
    end

    context "Rule 2: Live cell with 2 or 3 neighbours revive" do

      it "should keep live cell with 2 neighbours" do
        game = Game.new(world,[[0,1],[1,1],[2,1]])
        expect(game.world.live_neighbours_around_cell(game.world.cell_grid[1][1]).count).to eq(2)
        expect(game.world.live_neighbours_around_cell(game.world.cell_grid[1][0]).count).to eq(3)
        expect(game.world.live_neighbours_around_cell(game.world.cell_grid[2][1]).count).to eq(1)
        game.next_life_span!
        expect(game.world.cell_grid[0][1]).to be_dead
        expect(game.world.cell_grid[1][1]).to be_alive
        expect(game.world.cell_grid[2][1]).to be_dead
      end

      it "should keep live cell with 3 neighbours" do
        game = Game.new(world,[[0,1], [1,1], [2,1], [1,2]])
        expect(game.world.live_neighbours_around_cell(game.world.cell_grid[1][1]).count).to eq(3)
        expect(game.world.live_neighbours_around_cell(game.world.cell_grid[1][0]).count).to eq(3)
        expect(game.world.live_neighbours_around_cell(game.world.cell_grid[2][1]).count).to eq(2)
        game.next_life_span!
        expect(game.world.cell_grid[0][1]).to be_alive
        expect(game.world.cell_grid[1][0]).to be_alive
        expect(game.world.cell_grid[2][1]).to be_alive
      end
    end

    context "Rule 3: Live cell with more than 3 live neighbour dies" do

      it "should keep live cell with 2 neighbours" do
        game = Game.new(world,[[0,1],[1,1],[1,2],[2,1],[2,2]])
        game.next_life_span!
        expect(game.world.cell_grid[1][1]).to be_dead
      end
    end
    context "Rule 4: Live cell with 2 or 3 neighbours revive" do

      it "should keep live cell with 2 neighbours" do
        game = Game.new(world,[[0,1],[1,1],[1,2],[2,1],[2,2]])
        game.next_life_span!
        expect(game.world.cell_grid[0][2]).to be_alive
      end
    end
  end
end