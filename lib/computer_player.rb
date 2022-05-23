require './lib/board'
require './lib/ship'
require './lib/cell'

class ComputerPlayer

  attr_reader :board
  def initialize
    @board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @ships = [cruiser, submarine]
    @coordinate_array = @board.cells.keys
  end

  def ship_placement
    @ships.each do |ship|
      coordinates = []
      until @board.valid_placement?(ship,coordinates) do
        direction = rand(2)
        coordinates = []
        starting_point = rand(16)
        coordinates << @coordinate_array[starting_point]
        if direction == 0
          range = Array (1 .. (ship.length - 1))
           range.each do |index|
             coordinates << @coordinate_array[starting_point + index]
           end
        else
          range = Array (1 .. (ship.length - 1))
           range.each do |index|
             coordinates << @coordinate_array[starting_point + index * 4]
           end
         end
      end
      @board.place(ship, coordinates)
    end

  end

end
