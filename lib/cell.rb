class Cell
    attr_reader :coordinate,
                :ship
    
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

    def fire_upon
        @fired_upon = true
        ship.hit if @ship
    end

    def fired_upon?
        @fired_upon
    end

    def render
        if ship.hit
            "H"
        elsif ship.sunk? == true 
            "X"
        else
            "M"
        end
    end
end