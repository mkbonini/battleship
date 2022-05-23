class Game

  def initialize
    computer = ComputerPlayer.new
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
    computer.ship_placement
    #puts computer.board.render(true)
    #puts "got to setup"
  end
end
