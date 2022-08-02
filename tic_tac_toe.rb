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
        puts "\n"
        "Match three symbols in a row to win"
    end

    def winner_check(playerSymbol)
        if @@board.any? do |row| row.all? { |symbol| symbol == playerSymbol } end
            puts "You won!" # check all three horizontal wins
        elsif @@board[0][0] == playerSymbol && @@board[1][0] == playerSymbol && @@board[2][0] == playerSymbol
            puts "You won!" # check the first vertical win
        elsif @@board[0][1] == playerSymbol && @@board[1][1] == playerSymbol && @@board[2][1] == playerSymbol
            puts "You won!" # check the second vertical win
        elsif @@board[0][2] == playerSymbol && @@board[1][2] == playerSymbol && @@board[2][2] == playerSymbol
            puts "You won!" # check the third vertical win
        elsif @@board[0][0] == playerSymbol && @@board[1][1] == playerSymbol && @@board[2][2] == playerSymbol
            puts "You won!" # check "backslash" win
        elsif @@board[0][2] == playerSymbol && @@board[1][1] == playerSymbol && @@board[2][0] == playerSymbol
            puts "You won!" # check "forward slash" win
        elsif @@board.flatten.sort.join("").include? "OOOOO"
            puts "it's a draw" # check for a draw where p1 picked "O"
        elsif @@board.flatten.sort.join("").include? "XXXXX"
            puts "it's a draw" # checkf or a draw where p1 picked "X"
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
        puts "#{@name}, choose one of the remaining positions"
        number = gets
        if @@board.all? do |rows| rows.all? { |symbol| symbol != (number.to_i).to_s } end
            puts "\n"
            puts "Try again"
            play_round(playerSymbol)
        end
        @@board.map! { |row| row.map { |x| x == (number.to_i).to_s ? playerSymbol : x }}
        winner_check(playerSymbol)
    end

end



puts "Player 1, enter your name:"
player1 = Player.new(gets.chomp)

player1.symbol_pick()


puts "Player 2, enter your name:"
player2 = Player.new(gets.chomp)

player2.symbol_pick()

puts "\n"

i = 1
until i == 10
    if i % 2 == 0
        player2.play_round(player2.p2symbol)
        puts "\n"
    elsif i % 2 == 1
        player1.play_round(player1.p1symbol)
        puts "\n"
    end
    i += 1
end
