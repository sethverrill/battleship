# Setup:

# Computer can place ships randomly in valid locations
# User can enter valid sequences to place both ships
# Entering invalid ship placements prompts user to enter 
# valid placements

class MainMenu
    def initialize
    end


    def welcome
        "Welcome to BATTLESHIP! \nEnter p to play or q to quit"
    end

    def get_user_input
        gets.chomp
    end

    def start_game
        if get_user_input.downcase == "p"
            "Beginning BATTLESHIP!"
        elsif get_user_input.downcase == "q"
            "Sorry to see you go."
        else get_user_input != "p" || get_user_input != "q"
            "I didn't understand your selection, try again."
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

end

