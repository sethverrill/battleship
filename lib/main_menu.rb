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
            puts "Beginning BATTLESHIP!"
            @board_size = choose_board_size
            true
        elsif input == "q"
            "Sorry to see you go."
        else 
            "I didn't understand your selection. Please try again."
        end
    end

    def choose_board_size
        print "Please choose the size of board you would like to play on:\n" +
        "Enter 1 for 4x4\n" +
        "Enter 2 for 8x8\n" +
        "Enter 3 for 12x12\n" +
        "Enter 4 for 20x20\n"
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
        @board_size
    end

    def placement_instructions
        instructions = "I have laid out my ships on the grid.\n" +
                      "You now need to lay out your ships.\n" +                     
                      " #{(1..@board_size).map { |num| num.to_s.rjust(2) }.join(' ')}\n"
                      ('A'..('A'.ord + @board_size - 1).chr).each do |letter|
                        instructions += "#{letter} " + (1..@board_size).map { '. ' }.join(' ') + "\n"
                      end
                      instructions
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

