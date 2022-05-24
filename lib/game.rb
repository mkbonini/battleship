require './lib/game'
require './lib/computer_player'

class Game

  def initialize
    @computer = ComputerPlayer.new
    @board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @ships = [cruiser, submarine]
    @player_shots = []
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
    #Board size
      puts "Enter a desired board height between 3 and 26 (default is 4)"
      @height = gets.chomp.to_i
      if @height < 3 || @height > 26
        @height = 4
      end

      puts "Enter a desired board width between 3 and 26 (default is 4)"
      @width = gets.chomp.to_i
      if @width < 3 || @width > 26
        @width = 4
      end

    #make boards at new size
      @board.make_cells(@height, @width)
      @computer.board.make_cells(@height, @width)

      puts "you are playing on a #{@height} by #{@width} board.\n\n"

    #Custom ships
    puts "would you like to create custom ships?"
    puts "Default you have a cruizer (3 units long) and sub (2 units long)"
    puts "enter y to create ship or n to continue to the game"
    input = gets.chomp.downcase

    if input == 'y'
      custom_ships
    end
    #Ship placement
      @computer.ship_placement
      puts "I have laid out my ships on the grid."
      puts "You now need to lay out your #{@ships.length} ships."
      puts "Coordinates should be entered with a space between"
      puts @board.render

      @ships.each do |ship|
        puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)"
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
    #Board Output
      puts "\n=============COMPUTER BOARD============="
      puts @computer.board.render(true)
      puts "==============PLAYER BOARD=============="
      puts @board.render(true)
      puts "Enter the coordinate for your shot"
      input = gets.chomp.upcase
      until @board.valid_coordinate?(input) do
        puts "That is invalid coordinate. Please try again"
        input = gets.chomp.upcase
      end

    #player shot
      if !@player_shots.include?(input)
          @computer.board.cells[input].fired_upon
          @player_shots << input
        if @computer.board.cells[input].empty?
          puts "\nYour shot on #{input} was a miss"
        else
          if @computer.board.cells[input].ship.sunk?
            puts "\nYour shot on #{input} sunk my #{@computer.board.cells[input].ship.name}"
          else
            puts "\nYour shot on #{input} was a hit"
          end
        end
      else
        puts "\nYou already shot at #{input} bozo! Good luck next turn"
      end

    #computer shot
      computer_shot = @computer.shot
      @board.cells[computer_shot].fired_upon
      if @board.cells[computer_shot].empty?
        puts "Computer shot on #{computer_shot} was a miss"
      else
        if @board.cells[computer_shot].ship.sunk?
          puts "Computer shot on #{computer_shot} sunk your #{@board.cells[computer_shot].ship.name}"
        else
          puts "Computer shot on #{computer_shot} was a hit"
        end
      end

    #GAME OVER or repeat turn
      if @computer.ships.all?{|ship| ship.sunk?}
        puts "\n\n\nGame Over You won\n\n\n"
        game_over
      elsif @ships.all?{|ship| ship.sunk?}
        puts "\n\n\nGame Over I win\n\n\n"
        game_over
      else
        turn
      end
    end

  def game_over
    @computer = ComputerPlayer.new
    @board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @ships = [cruiser, submarine]
    @player_shots = []
    start
  end

  def custom_ships
    puts "Enter ship name"
    ship_name = gets.chomp
    puts "Enter ship length (must be less than the size of the board)"
    ship_length = gets.chomp.to_i
    until ship_length <= @height || ship_length <= @width do
      puts "invalid length it must be less than the height or the width. Try again:"
      ship_length = gets.chomp.to_i
    end
    @ships << Ship.new(ship_name,ship_length)
    @computer.ships << Ship.new(ship_name,ship_length)

    puts "would you like to create another ship? (y or n)"
    input = gets.chomp.downcase
    if input == 'y'
      custom_ships
    end

  end
end
