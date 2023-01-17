require_relative "../lib/tic_tac_toe.rb"

describe "#winner" do
    let(:game) { TicTacToe.new }
  
    context "when X wins" do
      before do
        game.board[0][0] = :X
        game.board[0][1] = :X
        game.board[0][2] = :X
      end
  
      it "returns X as the winner" do
        expect(game.winner).to eq :X
      end
    end
  
    context "when O wins" do
      before do
        game.board[0][0] = :O
        game.board[0][1] = :O
        game.board[0][2] = :O
      end
  
      it "returns O as the winner" do
        expect(game.winner).to eq :O
      end
    end
  
    context "when there is no winner" do
      it "returns nil" do
        expect(game.winner).to be_nil
      end
    end

end

describe TicTacToe do
  subject(:game) { TicTacToe.new }
    
  context "when a valid move is made" do
    before do
      allow(game).to receive(:gets).and_return("0 2")
      game.make_move(:x)
    end
    
    it "updates the board with the player's symbol" do
      expect(game.board[0][2]).to eq :x
    end
  end

  subject(:invalid_game) { TicTacToe.new }

  context "when an invalid move is made" do
    
    it "prints an error message to std out" do
      allow(invalid_game).to receive(:gets).and_return("4 5\n", "1 2\n")
      expect { invalid_game.make_move(:x) }.to output(/Invalid input. Please enter a number between 0 and 2 for both row and column./).to_stdout
    end 
    
  end 

end
