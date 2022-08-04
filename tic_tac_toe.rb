class Board
  @@board = [
    %w[1 2 3],
    %w[4 5 6],
    %w[7 8 9]
  ]

  @@game_status = 'going'

  def self.game_status
    @@game_status
  end

  def self.board # displays the board as a grid when printed
    @@board.each do |r|
      puts r.each { |p| p }.join(' ')
    end
    puts "\n"
    'Match three symbols in a row to win'
  end

  def reset_board
    @@board = [
      %w[1 2 3],
      %w[4 5 6],
      %w[7 8 9]
    ]
  end
end

class Player < Board
  attr_reader :name, :p1symbol, :p2symbol

  @@player_count = 0
  @@choice_symbol = ''

  def initialize(name)
    @name = name
    @@player_count += 1
  end

  def self.player_count
    @@player_count
  end

  def symbol_pick
    if @@player_count == 1
      puts 'Pick your symbol: O / X'
      @answer = gets.chomp.upcase
      if @answer != 'X' && @answer != 'O'
        puts "\n"
        puts 'Please enter X or O'
        symbol_pick
      else
        @p1symbol = @answer
        @@choice_symbol = @answer
      end
    else # checks player1 choice and assigns the opposite to player2
      @p2symbol = if @@choice_symbol == 'O'
                    'X'
                  else
                    'O'
                  end
    end
  end

  def play_round(player, playerSymbol)
    p Player.board
    puts "#{@name}, choose one of the remaining positions"
    number = gets
    if @@board.all? { |rows| rows.all? { |symbol| symbol != number.to_i.to_s } }
      puts "\n"
      puts 'Try again'
      play_round(player, playerSymbol)
    end
    @@board.map! { |row| row.map { |x| x == number.to_i.to_s ? playerSymbol : x } }
    winner_check(player, playerSymbol)
  end

  def play_again
    playAgain = gets.chomp.upcase
    if playAgain == 'Y'
      reset_board
    elsif playAgain == 'N'
      @@game_status = 'over'
    else
      puts "\n"
      puts 'Please make a valid selection: y/n'
      play_again
    end
  end

  def winner_found(player)
    puts "\n"
    puts "#{player} won!"
    p Player.board
    puts 'Would you like to play again? y/n'
    play_again
  end

  def draw
    puts "\n"
    puts "It's a draw!"
    p Player.board
    puts 'Would you like to play again? y/n'
    play_again
  end

  def winner_check(player, playerSymbol)
    if @@board.any? { |row| row.all? { |symbol| symbol == playerSymbol } }
      winner_found(player) # check all three horizontal wins
    elsif @@board[0][0] == playerSymbol && @@board[1][0] == playerSymbol && @@board[2][0] == playerSymbol
      winner_found(player) # check the first vertical win
    elsif @@board[0][1] == playerSymbol && @@board[1][1] == playerSymbol && @@board[2][1] == playerSymbol
      winner_found(player) # check the second vertical win
    elsif @@board[0][2] == playerSymbol && @@board[1][2] == playerSymbol && @@board[2][2] == playerSymbol
      winner_found(player) # check the third vertical win
    elsif @@board[0][0] == playerSymbol && @@board[1][1] == playerSymbol && @@board[2][2] == playerSymbol
      winner_found(player) # check "backslash" win
    elsif @@board[0][2] == playerSymbol && @@board[1][1] == playerSymbol && @@board[2][0] == playerSymbol
      winner_found(player) # check "forward slash" win
    elsif @@board.flatten.sort.join('').include? 'OOOOO'
      draw # check for a draw where p1 picked "O"
    elsif @@board.flatten.sort.join('').include? 'XXXXX'
      draw # check for a draw where p1 picked "X"
    end
  end
end

puts 'Player 1, enter your name:'
player1 = Player.new(gets.chomp)

player1.symbol_pick

puts 'Player 2, enter your name:'
player2 = Player.new(gets.chomp)

player2.symbol_pick

puts "\n"

i = 1

until Board.game_status == 'over'
  if i.even? # use modulo to swap between turns
    player2.play_round(player2.name, player2.p2symbol)
    puts "\n"
  elsif i.odd?
    player1.play_round(player1.name, player1.p1symbol)
    puts "\n"
  end
  i += 1
end
