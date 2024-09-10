class MainMenu
    attr_reader :board_size
    def initialize
        @board_size = 4
    end

    def welcome
        "Welcome to BATTLESHIP! \nEnter p to play or q to quit"
    end

    def start_game
        input = gets.chomp.downcase
        if input == "p"
            "Beginning BATTLESHIP!"
        elsif input == "q"
            "Sorry to see you go."
        else 
            "I didn't understand your selection. Please try again."
        end
    end

    def choose_board_size
        "Please choose the size of board you would like to play on:"
        "Enter 1 for 4x4"
        "Enter 2 for 8x8"
        "Enter 3 for 12x12"
        "Enter 4 for 20x20"
        input = gets.chomp
        case input
        when "1"
            @board_size = 4
        when "2"
            @board_size = 8
        when "3"
            @board_size = 12
        when "4"
            @board_size = 20
        else
            "That is not a valid selection. Playing with default board"
            @board_size = 4
        end
    end

    def placement_instructions
        "I have laid out my ships on the grid.\n" +
                      "You now need to lay out your two ships.\n" +
                      "The Cruiser is three units long and the Submarine is two units long.\n" +
                      "  1 2 3 4\n" +
                      "A . . . .\n" +
                      "B . . . .\n" +
                      "C . . . .\n" +
                      "D . . . .\n"
    end

    def place_ship(ship, board)
        puts "Enter #{ship.length} coordinates for the #{ship.name}"
        coordinates = gets.chomp.upcase.split
        if board.valid_placement?(ship, coordinates)
          board.place(ship, coordinates)
          true
        else
          "Those coordinates are invalid"
        end
    end
end

