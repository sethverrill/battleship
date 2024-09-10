require './spec/spec_helper'

RSpec.describe Turn do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @player_board = Board.new
    @computer_board = Board.new 
    @main_menu = MainMenu.new
    @turn = Turn.new(@player_board, @computer_board)
  end

  describe '#initialize turn' do
    it 'exisits' do
      expect(@turn).to be_an_instance_of(Turn)
    end
  end

  describe '#display boards' do
    before do

      @player_board.place(@cruiser, ["A1", "A2", "A3"])
      @player_board.place(@submarine, ["C1", "D1"])
      @computer_board.place(@cruiser, ["B1", "B2", "B3"])
      @computer_board.place(@submarine, ["D1", "D2"])

      @player_board.cells["B2"].fire_upon
      @computer_board.cells["A1"].fire_upon
      @computer_board.cells["A4"].fire_upon
    end

      it 'displays both boards correctly' do
        expected_output = <<~BOARDS
          =============COMPUTER BOARD=============
            1 2 3 4
          A M . . M
          B . . . .
          C . . . .
          D . . . .
          ==============PLAYER BOARD==============
            1 2 3 4
          A S S S .
          B . M . .
          C S . . .
          D S . . .
        BOARDS

        expect { @turn.display_boards }.to output(expected_output).to_stdout
      end
  end

  describe '#player takes a turn' do
  #As I was writting this it stopped making sense and I don't think the following tests are written correctly.
  # I was getting really confused with the randomness of the computer placing ships and guessing coordinates.
  # Also I'm not sure that I called the method 'place_computer_ships' correctly because I didn't put '@menu'.
    xit "player chooses a coordinate and it's a hit" do
      allow(@turn).to receive(:gets).and_return("A1")
      @computer_board.place_computer_ships

      expect(@turn.p_take_shot).to eq("H")
    end

    xit "player chooses a coodinate and it's a miss" do
      allow(@turn).to receive(:gets). and_return("A4")
      @computer_board.place_computer_ships

      expect(@turn.p_take_shot).to eq("M")
    end

    xit "player chooses a coordinate and it's invalid" do
      allow(@turn).to receive(:gets). and_return("E6")

      expect(@turn.p_take_shot).to eq("Sorry, that coordinate is not on the board. Try again.")
    end
  end

  describe '#computer takes a turn' do
    xit "computer chooses a coordiante to fire on" do
      @player_board.place(@cruiser, ["A1", "A2", "A3"])

      shot = @turn.comp_take_shot
      expect(["H", "M", "X"]).to include(shot)
    end
  end
  
  describe "#gives feedback" do
    xit "player had a hit" do
      allow(@turn).to receive(:p_take_shot). and_return("A1")
      expect(@turn.player_feedback).to eq("Your shot on A1 was a hit!")
    end

    xit "player had a miss" do
      allow(@turn).to receive(:p_take_shot). and_return("A4")
      expect(@turn.player_feedback).to eq("Your shot on A4 was a miss.")
    end

    xit "computer had a hit" do
      allow(@turn).to receive(:comp_take_shot).and_return("A1")
      expect(@turn.computer_feedback).to eq("My shot on A1 was a hit!")
    end

    xit "computer had a miss" do
      allow(@turn).to receive(:comp_take_shot).and_return("B1")
      expect(@turn.computer_feedback).to eq("My shot on B1 was a miss.")
    end
  end 
end