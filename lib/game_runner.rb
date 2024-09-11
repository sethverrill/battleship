require './spec/spec_helper'

class GameRunner

  def initialize
    @main_menu = MainMenu.new
    @board_size = @main_menu.board_size
    @player_board = nil
    @computer_board = nil
    @player_ships = nil
    @computer_ship = nil
    @turn = nil
  end

  def start
    puts @main_menu.welcome
    response = @main_menu.start_game
    puts response
    return unless response == "Beginning BATTLESHIP!"

    @board_size = @main_menu.choose_board_size
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
  end
end

game = GameRunner.new
game.start