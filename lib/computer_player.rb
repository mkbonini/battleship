class ComputerPlayer
  def initialize
    @board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @ships = [cruiser, submarine]
    @coordinate_array = @board.cells.keys
  end

  def ship_placement
    ships.each do |ship|
      direction = rand(2)
      coordinates = []
      until valid_placement?(ship,coordinates) do
        #code to generate coordinates

      end
      #place ship
    end

end
