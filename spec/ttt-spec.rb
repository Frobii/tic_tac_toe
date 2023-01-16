require_relative "../lib/tic_tac_toe.rb"

describe TicTacToe do
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
