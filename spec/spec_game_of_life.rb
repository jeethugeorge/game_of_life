#Test Cases using Rspec
require 'rspec'

require_relative '../lib/game'
require_relative '../lib/world'
require_relative '../lib/cell'


describe "the game of life" do

  let!(:world) { World.new }

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
end