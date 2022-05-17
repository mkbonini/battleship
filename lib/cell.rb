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
  if empty? == false
    @ship.hit
  end
end

def render(revealed = false)
  if fired_upon? == true
    if empty?
      return "M"
    elsif ship.sunk?
      return "X"
    else
      return "H"
    end
  else
    if revealed == true && empty? == false
      return "S"
    else
      return "."
    end
  end
end
























end
