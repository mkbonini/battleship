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



















end
