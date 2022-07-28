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
    attr_reader :p1symbol
    attr_reader :p2symbol


    @@player_count = 0
    @@choice_symbol = ""

    def initialize(name)
        @name = name
        @@player_count += 1
    end

    def self.player_count()
        @@player_count
    end

   def symbol_pick()
        if @@player_count == 1
            puts "Pick your symbol: O / X"
            @answer = gets.chomp
            if @answer != "X" && @answer != "O"
                puts "Please enter X or O"
                symbol_pick()
            else 
                @p1symbol = @answer
                @@choice_symbol = @answer
            end
        else # checks player1 choice and assigns the opposite to player2
            if @@choice_symbol == "O"
                @p2symbol = "X"
            else
                @p2symbol = "O"
            end
        end
    end
    
    def play_round(playerSymbol)
        p Player.board
        puts "#{@name} choose one of the remaining positions"
        number = gets
        p @@board.map! { |row| row.map { |x| x == (number.to_i).to_s ? playerSymbol : x }}
        p Player.board
    end

    
end



puts "Player 1, enter your name:"
player1 = Player.new(gets.chomp)

player1.symbol_pick()


puts "Player 2, enter your name:"
player2 = Player.new(gets.chomp)

player2.symbol_pick()


i = 1
until i == 10
    if i % 2 == 0
        player2.play_round(player2.p2symbol)
    elsif i % 2 == 1
        player1.play_round(player1.p1symbol)
    end
    i += 1
end
