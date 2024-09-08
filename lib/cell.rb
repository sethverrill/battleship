class Cell
    attr_reader :coordinate,
                :ship,
                :render
    
    def initialize(coordinate)
        @coordinate = coordinate 
        @ship = nil        
        @fired_upon = false
    end

    def place_ship(ship)        
        @ship = ship
    end

    def empty?
        @ship.nil?
    end  

    def fired_upon?
        @fired_upon
    end

    def fire_upon
        return false if fired_upon?
        @fired_upon = true
        @ship.hit if @ship
        true
    end            

    def render(show_ships = false)
        case
        when fired_upon?
            @ship ? (@ship.sunk? ? "X" : "H") : "M"
        when show_ships && @ship
            "S"
        else
            "."
        end
    end
end