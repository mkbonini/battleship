class Cell

attr_reader :coordinate, :ship


def initialize(coordinate)
  @coordinate = coordinate
  @fired = false
end

def empty?
  @ship == nil
end

def place_ship(ship_input)
  @ship = ship_input
end

def fired_upon?
  @fired
end

def fired_upon
  @fired = true
  @ship.hit

end 


















end
