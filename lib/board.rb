class Board
  attr_reader :cells  

  def initialize
    @cells = board_cells
  end

  def board_cells
    cells = {}
    ('A'..'D').each do |letter|
      (1..4).each do |number|
        coordinate = "#{letter}#{number}"
        cells[coordinate] = Cell.new(coordinate)        
      end
    end
    cells 
  end  
  #I think this method will need to be drastically changed once we expand board size

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def consecutive_coordinates?(coordinates)
    return false if coordinates.empty?
    # Distinguish between letters and numbers and to create a list of each
    letters = coordinates.map {|coord_letter| coord_letter[0]}
    numbers = coordinates.map {|coord_number| coord_number[1].to_i}
    # Check for consecutive letters. This will create a boolean.
    consecutive_letters = letters.each_cons(2).all? {|first, second| second.ord - first.ord == 1}
    #Check for consecutive numbers
    consecutive_numbers = numbers.each_cons(2).all? {|first, second| second - first == 1}
    # Checks if the coordiantes are consecutive using the arrays and booleans created above
    (letters.uniq.size == 1 && consecutive_numbers) || (numbers.uniq.size == 1 && consecutive_letters)
  end

  def valid_placement?(ship, coordinates)
      coordinates.length == ship.length &&
      coordinates.all? { |coord| valid_coordinate?(coord) } &&
      consecutive_coordinates?(coordinates) &&
      coordinates.none? { |coord| @cells[coord].ship }
  end
    
  def place(ship, coordinates)    
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
        # require 'pry';binding.pry
      end
      true
    else
      false
    end
  end

  def render(show_ships = false)
    string = top_row
    ('A'..'D').each do |letter|
      string += "#{letter} "
      (1..4).each do |number|
        coordinate = "#{letter}#{number}"
        string += "#{@cells[coordinate].render(show_ships)} "
      end
      string += "\n"
    end
    string
  end

  def top_row
    return "  #{board_numbers.join(' ')} \n"
  end

  def board_numbers
    (1..4).to_a
  end
end