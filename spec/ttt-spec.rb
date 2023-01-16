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

describe "#make_move" do
    let(:game) { TicTacToe.new }
    
    context "when a valid move is made" do
        before do
            allow(game).to receive(:gets).and_return("0 2")
            game.make_move(:x)
        end
        
        it "updates the board with the player's symbol" do
            expect(game.board[0][2]). to eq :x
        end
    end

end
