require './spec/spec_helper'

RSpec.describe Turn do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @player_board = Board.new
    @computer_board = Board.new 
    @main_menu = MainMenu.new
    @turn = Turn.new(@player_board, @computer_board)

    @player_board.place(@cruiser, ["A1", "A2", "A3"])
    @player_board.place(@submarine, ["C1", "D1"])
    @computer_board.place(@cruiser, ["B1", "B2", "B3"])
    @computer_board.place(@submarine, ["D1", "D2"])
  end

  describe '#initialize turn' do
    it 'exisits' do
      expect(@turn).to be_an_instance_of(Turn)
    end

    it 'has one of each board' do
      expect(@turn.player_board).to eq(@player_board)
      expect(@turn.computer_board).to eq(@computer_board)
    end
  end

  describe '#display boards' do   
    it 'displays both boards correctly' do
      @player_board.cells["B2"].fire_upon
      @computer_board.cells["A1"].fire_upon
      @computer_board.cells["A4"].fire_upon
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
    it "player chooses a coordinate and it's a hit" do
      allow(@turn).to receive(:gets).and_return("B1\n")
      expect { @result = @turn.p_take_shot }.to change { @computer_board.cells["B1"].fired_upon? }.from(false).to(true)      
      expect(@result).to eq("Your shot on B1 was a hit!")
    end

    it "player chooses a coodinate and it's a miss" do
      allow(@turn).to receive(:gets).and_return("A4\n")
      expect { @result = @turn.p_take_shot }.to change { @computer_board.cells["A4"].fired_upon? }.from(false).to(true)
      expect(@result).to eq("Your shot on A4 was a miss.")
    end    

    it 'cannot shoot at the same cell twice' do
      @computer_board.cells["A4"].fire_upon
      allow(@turn).to receive(:gets).and_return("A4\n", "B1\n")      
      expect { @result = @turn.p_take_shot }.to output("Enter a coordinate to fire upon: You have already fired here. Choose another coordinate.Enter a coordinate to fire upon: ").to_stdout
      expect(@result).to eq("Your shot on B1 was a hit!")   
    end

    it 'handles invalid coordinates' do
      allow(@turn).to receive(:gets).and_return("E1\n", "A1\n")
      expect { @turn.p_take_shot }.to output(/Sorry, that coordinate is not on the board. Try again./).to_stdout
    end
  end

  describe '#computer takes a turn' do
    it "computer chooses a coordiante to fire on" do     
      shot = @turn.comp_take_shot
      expect(["H", "M", "X"]).to include(shot)
    end
  end
  
  describe "#gives feedback" do
    it "computer had a hit" do
      expect(@turn.computer_feedback("A1", "H")).to eq("My shot on A1 was a hit!")
    end

    it "computer had a miss" do
      expect(@turn.computer_feedback("B1", "M")).to eq("My shot on B1 was a miss.")
    end
  end 
end