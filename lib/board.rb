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




