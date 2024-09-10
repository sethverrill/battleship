require './spec/spec_helper'

RSpec.describe Turn do
  before(:each) do
    @turn = Turn.new 
  end

  describe '#initialize turn' do
    it 'exisits' do
      expect(@turn).to be_an_instance_of(Turn)
    end
  end

  describe '#player takes a turn' do
    before(:each) do
      @board = Board.new 
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
    end

      it "player chooses a coordinate and it's a hit" do
        allow(@turn).to receive(:gets).and_return("A1")
        @board.place(@cruiser, ["A1", "A2", "A3"])

        expect(@turn.p_take_shot).to eq("H")
      end

      it "player chooses a coodinate and it's a miss" do
        allow(@turn).to receive(:gets). and_return("A4")
        @board.place(@cruiser, ["A1", "A2", "A3"])

        expect(@turn.p_take_shot).to eq("M")
      end

      it "player chooses a coordinate and it's invalid" do
        allow(@turn).to receive(:gets). and_return("E6")

        expect(@turn.p_take_shot).to eq("Sorry, that coordinate is not on the board. Try again.")
  end

  describe '#computer takes a turn' do
    it "computer chooses a coordiante to fire on" do
      @board.place_computer_ships

      shot = turn.comp_take_shot
      expect(["H", "M", "X"]).to include(shot)
    end
  end
  
  describe "#gives feedback" do
    it "player had a hit"
      allow(@turn).to receive(:p_take_shot). and_return("A1")
      expect(@turn.player_feedback).to eq("Your shot on A1 was a hit!")
    end

    it "player had a miss" do
      allow(@turn).to receive(:p_take_shot). and_return("A4")
      expect(@turn.player_feedback).to eq("Your shot on A4 was a miss.")
    end

    it "computer had a hit" do
      allow(@turn).to receive(:comp_take_shot).and_return("A1")
      expect(@turn.computer_feedback).to eq("My shot on A1 was a hit!")
    end

    it "computer had a miss" do
      allow(@turn).to receive(:comp_take_shot).and_return("B1")
      expect(@turn.computer_feedback).to eq("My shot on B1 was a miss.")
    end
  end 
end