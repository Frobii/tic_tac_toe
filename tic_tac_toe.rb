class Board
    @@board = [
        ['1', '2', '3'],
        ['4', '5', '6'],
        ['7', '8', '9']
    ]

    def self.board # displays the board as a grid when printed
        @@board.each do |r|
            puts r.each { |p| p }.join(" ")
        end
    end
end

class Player < Board
    attr_reader :name

    def initialize(name)
        @name = name
    end

end

frobe = Player.new("Frobe")

p Player.board

