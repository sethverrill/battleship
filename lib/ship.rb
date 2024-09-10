class Ship
    attr_reader :name,
                :length,
                :health

    def initialize(name, length)
        @name = name
        @length = length
        @health = length       
    end

    def hit
        @health -=1 if @health > 0
    end   

    def sunk?
        @health ==0
    end

    def self.gets_input
        gets.chomp
    end

    def self.build_ships
        ships = []
        puts "Would you like to create custom ships? (y/n)"
        response = gets_input.downcase

        case response
        when 'n'
            ships << Ship.new("Cruiser", 3)
            ships << Ship.new("Submarine", 2)
            ships << Ship.new("Dinghy", 1)
        when 'y'
            loop do 
                puts "Enter ship name (or 'done' to finish):"
                name = gets_input
                break if name.downcase == 'done'

                puts "Enter ship length:"
                length_str = gets_input
                length = length_str.to_i

                if valid_ship?(name, length)
                    ships << Ship.new(name, length)
                else
                    puts "Invalid ship. Please try again"
                end
            end
        else
            puts "Invalid response. Enter 'y' or 'n'."
            ships = build_ships
        end
        ships
    end

    def self.valid_ship?(name, length)
        length > 0 && !name.empty?
    end
end