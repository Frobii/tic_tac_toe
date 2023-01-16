class TicTacToe
  attr_accessor :board

  def initialize
    @board = Array.new(3) { Array.new(3) }
  end

  def play
    loop do
      display_board
      make_move(:X)
      break if game_over?
      display_board
      make_move(:O)
      break if game_over?
    end
    if winner
      puts "#{winner} wins!"
    else
      puts "It's a tie!"
    end
  end

  def display_board
    board.each do |row|
      puts row.map { |cell| cell || "-" }.join(" ")
    end
  end

  def make_move(player)
    loop do
      puts "\n"
      puts "#{player}, please enter the row and column (e.g. '1 2') for your move:"
      row, col = gets.split.map(&:to_i) rescue [nil,nil]
      puts "\n"
      if row.nil? || col.nil?
        puts "Invalid input. Please check your input and try again."
      elsif !(0..2).include?(row) || !(0..2).include?(col)
        puts "Invalid input. Please enter a number between 0 and 2 for both row and column."
      elsif board[row][col].nil?
        board[row][col] = player
        break
      else
        puts "That spot is already taken! Please try again."
      end
    end
end

  def game_over?
    winner || board_full?
  end

  def board_full?
    board.flatten.none?(&:nil?)
  end

  def winner
    winning_lines.each do |line|
      return line.first if line.uniq.size == 1
    end
    nil
  end

  def winning_lines
    lines = []
    lines += board
    lines += board.transpose
    lines << [board[0][0], board[1][1], board[2][2]]
    lines << [board[0][2], board[1][1], board[2][0]]
    lines
  end
end

game = TicTacToe.new
game.play
