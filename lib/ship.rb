class Ship
    attr_reader :name,
                :length,
                :health
    def initialize(name, length)
        @name = name
        @length = length
        @starting_health = 3
        @health = health
    end

    def hit
        @starting_health -=1
    end

    def health
        @starting_health
    end

    def sunk?
        @starting_health ==0
    end
end