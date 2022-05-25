class Board
  attr_reader :cells, :height, :width
  def initialize(height = 4, width = 4)
    @height = height
    @width = width
    @cells = Hash.new
    make_cells(@height,@width)
  end

  def make_cells(height, width)
    @cells.clear()
    @height = height
    @width = width
    letters = Array ('A' .. (height + 64).chr)
    numbers = Array (1 .. width)

    letters.each do |letter|
      numbers.each do |number|
        coordinate = letter + number.to_s
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def coordinate_split(range)
    letters = []
    numbers = []

    range.each do |coordinate|
      letters  << coordinate.split("",2)[0].ord
      numbers << coordinate.split("",2)[1].to_i
    end
    return [letters, numbers]
  end

  def placement_hard_fails(ship, range)

    range.each do |coordinate|
      if !valid_coordinate?(coordinate) || !@cells[coordinate].empty?
        return true
      end
    end

    if ship.length != range.length
      return true
    end

    return false
  end

  def consecutive_numbers(letters, numbers)
    numbers.each_cons(2).all? {|a,b| b == a + 1} && letters.each_cons(2).all? {|a,b| b == a}
  end

  def consecutive_letters(letters, numbers)
    letters.each_cons(2).all? {|a,b| b == a + 1} && numbers.each_cons(2).all? {|a,b| b == a}
  end

  def valid_placement?(ship, range)

    if placement_hard_fails(ship, range)
      return false
    end

    letters = coordinate_split(range)[0]
    numbers = coordinate_split(range)[1]

    if consecutive_letters(letters,numbers)
        return true

    elsif consecutive_numbers(letters, numbers)
        return true

    else
      return false
    end
  end

  def place(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
  end

  def render( revealed = false)
    letters = Array ('A' .. (@height + 64).chr)
    numbers = Array (1 .. @width)

    render_output = " "
    numbers.each {|number| render_output << " " + number.to_s}
    render_output << " \n"

    letters.each do |letter|
      render_output << letter

      numbers.each do |number|
        if number / 10 == 0
          render_output << " " + @cells[letter + number.to_s].render(revealed)
        else
          render_output << "  " + @cells[letter + number.to_s].render(revealed)
        end
      end

      render_output << " \n"
    end

    render_output
  end

end
