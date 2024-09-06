class Cell
    attr_reader :coordinate,
                :ship,
                :render
    
    def initialize(coordinate)
        @coordinate = coordinate 
        @ship = nil
        @render = "."
        @fired_upon = false
    end

    def place_ship(ship)
        @render = "S"
        @ship = ship
    end

    def empty?
        @render == "."
    end  

    def fired_upon?
        @render != "." && @render != "S"
    end

    def fire_upon
        return false if fired_upon?
    
      @render = if @ship
                    @ship.hit
                    @ship.sunk? ? "X" : "H"
                else
                    "M"
                end
        true        
    end            

    def render(show_ships = false)
        if fired_upon?
            if @ship
                return "X" if @ship.sunk?
                return "H"
            else
                return "M"
            end
        else
            return "S" if show_ships && @ship
            return "."        
         end
    end
end