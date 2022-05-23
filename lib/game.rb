require './lib/game'
require './lib/computer_player'
class Game

  def initialize
    @computer = ComputerPlayer.new
    @board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @ships = [cruiser, submarine]
  end

  def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    until input == "p" || input == "q" do
        puts "Invalid Input"
        puts "Enter p to play. Enter q to quit."
        input = gets.chomp.downcase
      end
      if input == "p"
        setup
      end
      if input == "q"
        exit
      end
    end

  def setup
    @computer.ship_placement
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @board.render

    @ships.each do |ship|
      puts "Enter the square for the #{ship.name} (#{ship.length} spaces)"
      input = gets.chomp.upcase
      input_array = input.split(" ")
      until @board.valid_placement?(ship, input_array) do
        puts "Those are invalid coordinates. Please try again"
        input = gets.chomp.upcase
        input_array = input.split(" ")
      end
      @board.place(ship, input_array)
      puts @board.render(true)

    end

    turn
  end

  def turn
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render(true)
    puts "==============PLAYER BOARD=============="
    puts @board.render(true)
    puts "Enter the coordinate for your shot"
    input = gets.chomp.upcase
    until @board.valid_coordinate?(input) do
      puts "That is invalid coordinate. Please try again"
      input = gets.chomp.upcase
    end
    @computer.board.cells[input].fired_upon
    if @computer.board.cells[input].empty?
      puts "Your shot on #{input} was a miss"
    else
      if @computer.board.cells[input].ship.sunk?
        puts "Your shot on #{input} sunk my #{@computer.board.cells[input].ship.name}"
      else
        puts "Your shot on #{input} was a hit"
      end
    end

  end


end
