require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/computer_player'

require 'rspec'

RSpec.describe ComputerPlayer do
  it 'exists' do
    computer = ComputerPlayer.new

    expect(computer).to be_a(ComputerPlayer)
  end

  it 'computer player takes a shot' do
    computer = ComputerPlayer.new

    expect(computer.board.cells.keys.include?(computer.shot)).to be true
  end

end
