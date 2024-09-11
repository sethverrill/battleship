class Turn 
  attr_reader :player_board, :computer_board

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
  end

  def display_boards
    comp_board = "=============COMPUTER BOARD=============\n"
    comp_board += @computer_board.render
    p_board = "==============PLAYER BOARD==============\n"
    p_board += @player_board.render(true)
   
    puts comp_board
    puts p_board  
  end

  def p_take_shot
    loop do 
      print "Enter a coordinate to fire upon: "
      coordinate = gets.chomp.upcase
      if @computer_board.valid_coordinate?(coordinate)
        cell = @computer_board.cells[coordinate]
        if !cell.fired_upon?
          cell.fire_upon
          return cell.render
        else
          print "You have already fired here. Choose another coordinate."
        end
      else
          print "Sorry, that coordinate is not on the board. Try again."
      end
    end
  end

end