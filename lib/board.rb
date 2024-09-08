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

    letters = coordinates.map {|coord_letter| coord_letter[0]}
    numbers = coordinates.map {|coord_number| coord_number[1].to_i}

    consecutive_letters = letters.each_cons(2).all? {|first, second| second.ord - first.ord == 1}

    consecutive_numbers = numbers.each_cons(2).all? {|first, second| second - first == 1}

    (letters.uniq.size == 1 && consecutive_numbers) || (numbers.uniq.size == 1 && consecutive_letters)
  end
  
  def valid_placement?(ship, coordinates)
    if coordinates.length == ship.length
      if coordinates.all?  { |place| valid_coordinate?(place)}      
        if consecutive_coordinates?(coordinates)
         return true
        else
          puts "Those are invalid coordinates. Please try again:"
          return false
        end
      else
        puts "Those are invalid coordinates. Please try again:"
        return false
      end
    else
      puts "Those are invalid coordinates. Please try again:"
      return false
    end
  end
end




