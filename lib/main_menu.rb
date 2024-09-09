class MainMenu
    def initialize
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

    def place_computer_ships
        [@cruiser, @submarine].each do |ship|
            loop do
                coordinates = @board.cells.keys.sample(ship.length)
                if @board.valid_placement?(ship, coordinates)
                    @board.place(ship, coordinates)
                    break
                end
            end
        end
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

