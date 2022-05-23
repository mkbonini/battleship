require './lib/game'
require './lib/computer_player'

game = Game.new
computer = ComputerPlayer.new

computer.ship_placement
puts computer.board.render(true)

#game.start
