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

  xit 'empty?' do
    cell = Cell.new("B4")

    expect(cell.empty?).to be true
  end

  xit 'can place ships' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    expect(cell.ship).to eq(cruiser)
    expect(cell.empty?).to be false
  end

  xit 'fired_upon?' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    expect(cell.fired_upon?).to be false
  end

  xit 'fired_upon' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    cell.fired_upon

    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to be true
  end

  xit 'renders an empty cell' do
    cell = Cell.new("B4")

    expect(cell.render).to eq(".")

  end

  xit 'renders a miss' do
    cell = Cell.new("B4")

    cell.fired_upon

    expect(cell.render).to eq("M")
  end

  xit 'renders a ship' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship

    expect(cell.render).to eq(".")
    expect(cell.render(true)).to eq("S")
  end

  xit 'renders a hit' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship
    cell.fired_upon

    expect(cell.render).to eq("H")
  end

  xit 'renders a sunk ship' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship
    cell.fired_upon
    cruiser.hit
    cruiser.hit

    expect(cell.render).to eq("X")
  end
end
