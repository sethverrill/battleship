class Board
  attr_reader :cells,
              :size  

  def initialize(size = 4)
    @size = size
    @cells = board_cells    
  end

  def letter_range
    start_letter = "A"
    last_letter = (start_letter.ord + @size -1).chr
    (start_letter..last_letter)
  end

  def board_cells
    cells = {}
    letter_range.each do |letter|
      (1..@size).each do |number|
        coordinate = "#{letter}#{number}"
        cells[coordinate] = Cell.new(coordinate)        
      end
    end
    cells 
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def consecutive_coordinates?(coordinates)
    return false if coordinates.empty?
    letters = coordinates.map {|coord_letter| coord_letter[0]}
    numbers = coordinates.map {|coord_number| coord_number[1].to_i}
    consecutive_letters = letters.each_cons(2).all? {|first, second| second.ord - first.ord == 1}
    consecutive_numbers = numbers.each_cons(2).all? {|first, second| second - first == 1}
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
      end
      true
    else
      false
    end
  end

  def place_computer_ships(ships)
    ships.each do |ship|
      loop do
        coordinates = @board.cells.keys.sample(ship.length)
        if valid_placement?(ship, coordinates)
          place(ship, coordinates)
          break
        end
      end
    end
  end

  def render(show_ships = false)
    string = top_row
    letter_range.each do |letter|
      string += "#{letter} "
      (1..@size).each do |number|
        coordinate = "#{letter}#{number}"
        string += "#{@cells[coordinate].render(show_ships)} "
      end
      string += "\n"
    end
    string
  end

  def top_row
    return "  #{board_numbers.join(' ')}\n"
  end

  def board_numbers
    (1..@size).to_a
  end
end