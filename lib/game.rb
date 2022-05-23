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

    #puts computer.board.render(true)
    #puts "got to setup"
  end


end
