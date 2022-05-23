require './lib/board'
require './lib/ship'
require './lib/cell'

require 'rspec'

RSpec.describe Board do
  it 'exists' do
    board = Board.new

    expect(board).to be_a(Board)
  end

  it 'has cells' do
    board = Board.new

    expect(board.cells).to be_a(Hash)
    expect(board.cells["A1"]).to be_a(Cell)

  end

  it 'validates coordinates' do
    board = Board.new
    expect(board.valid_coordinate?("A1")).to be true
    expect(board.valid_coordinate?("D4")).to be true
    expect(board.valid_coordinate?("A5")).to be false
    expect(board.valid_coordinate?("E1")). to be false
    expect(board.valid_coordinate?("A22")).to be false
  end

  it 'validates placement/length' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
    expect(board.valid_placement?(submarine,["A2", "A3", "A4"])).to be false
  end

  it 'validate placement/consecutive' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
    expect(board.valid_placement?(submarine, ["A1", "C1"])).to be false
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to be false
  end
  it 'validates placement/diagonal' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])). to be false
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false

  end

  it 'validates placement/valid' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
  end

  it 'places ships' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.place(cruiser,["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    expect(cell_1.ship).to eq(cruiser)
    expect(cell_2.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cruiser)
    expect(cell_2.ship).to eq(cell_3.ship)
  end

  it 'has overlapping ships' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.place(cruiser,["A1", "A2", "A3"])

    expect(board.valid_placement?(submarine, ["A1", "B1"])).to be false

  end

  it 'can render the board' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser,["A1", "A2", "A3"])

    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")

end





end
