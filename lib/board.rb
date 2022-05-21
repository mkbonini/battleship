class Board
  attr_reader :cells
  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
    # @placed_coordinates = []
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, range)
    letters = []
    numbers = []

    range.each do |coordinate|
      letters  << coordinate.split("")[0].ord
      numbers << coordinate.split("")[1].to_i
    end
    range.each do |coordinate|
      # if @placed_coordinates.include?(coordinate)
      #   return false
      # end
      if !@cells[coordinate].empty? || !valid_coordinate?(coordinate)
        return false
      end
    end

    #require 'pry';binding.pry
    if ship.length != range.length
      return false

    elsif letters.each_cons(2).all? {|a,b| b == a + 1} && numbers.each_cons(2).all? {|a,b| b == a}
        return true

    elsif numbers.each_cons(2).all? {|a,b| b == a + 1} && letters.each_cons(2).all? {|a,b| b == a}
        return true
    else
      return false
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates) == true
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
        # @placed_coordinates << coordinate
      end
    end
  end

  def render( revealed = false)
    render_output = "  1 2 3 4 \n"
    letters = ["A", "B", "C", "D"]
    letters.each do |letter|

      render_output << letter + " " + @cells[letter + "1"].render(revealed) + " " + @cells[letter + "2"].render(revealed) + " " + @cells[letter + "3"].render(revealed) + " " + @cells[letter + "4"].render(revealed) + " \n"

    end
    render_output

  # "  1 2 3 4 \n" +
    # "A . . . . \n" +
    # "B . . . . \n" +
    # "C . . . . \n" +
    # "D . . . . \n"


  end





end
