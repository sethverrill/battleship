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
          if cell.render == "H"
            feedback_hit = "Your shot on #{coordinate} was a hit!"
            return feedback_hit
          elsif cell.render == "M"
            feedback_miss = "Your shot on #{coordinate} was a miss."
            return feedback_miss
          else feedback_sunk = "Your shot on #{coordinate} sunk my ship!"
            return feedback_sunk
          end
        else
          print "You have already fired here. Choose another coordinate."
        end
      else
          print "Sorry, that coordinate is not on the board. Try again."
      end
    end
  end

  def comp_take_shot 
    loop do
      print "Now it's my turn."
      coordinate = @player_board.cells.keys.sample
      cell = @player_board.cells[coordinate]
        if !cell.fired_upon?
          cell.fire_upon
          print "I fired on #{coordinate}"
          return cell.render
        else print "Whoops I have already fired on this coordinate, let me try again."
        end
    end
  end

  # def player_feedback
  #   p_take_shot
  #   if cell.render == "H"
  #     "Your shot on #{coordinate} was a hit!"
  #   else cell.render == "M"
  #     "Your shot on #{coordinate} was a miss."
  #   end
  # end
end