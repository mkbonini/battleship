require 'rspec'
require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  it 'exists' do
    cell = Cell.new("B4")

    expect(cell).to be_a(Cell)
  end

  it 'Coordinates' do
    cell = Cell.new("B4")

    expect(cell.coordinate).to eq("B4")
  end
  it 'has a ship' do
    cell = Cell.new("B4")

    expect(cell.ship).to eq(nil)
  end

  it 'empty?' do
    cell = Cell.new("B4")

    expect(cell.empty?).to be true
  end
end
