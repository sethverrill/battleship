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

    def health
        @starting_health
    end

    def sunk?
        false
    end
end