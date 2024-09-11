require './spec/spec_helper'

class GameRunner

  def initialize(main_menu)
    @main_menu = main_menu  
  end  

  def start
    loop do
      puts @main_menu.welcome
      game_started = @main_menu.start_game
      
      return unless game_started

      @board_size = @main_menu.board_size   
      @player_board = Board.new(@board_size)
      @computer_board = Board.new(@board_size)
      ships = Ship.build_ships
      @player_ships = ships
      @computer_ships = ships.map { |ship| Ship.new(ship.name, ship.length)}

      puts @main_menu.placement_instructions
      @player_ships.each do |ship|
        loop do
          result = @main_menu.place_ship(ship, @player_board)
          break if result == true
          puts result
        end
      end

      display_player_board

      @computer_board.place_computer_ships(@computer_ships)

      @turn = Turn.new(@player_board, @computer_board)

      loop do
        @turn.display_boards
        player_result = @turn.p_take_shot
        puts player_result
        break if @turn.game_over(@player_board, @computer_board)

        computer_result = @turn.comp_take_shot
        puts @turn.computer_feedback(@turn.coordinate_record.last, computer_result)
        break if @turn.game_over(@player_board, @computer_board)      
      end

      @turn.display_boards
      puts "Game Over!"

      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break unless answer == 'y'
    end
  end

    def display_player_board
      puts "Game on!"     
    end
  
end

main_menu = MainMenu.new
game = GameRunner.new(main_menu)
game.start