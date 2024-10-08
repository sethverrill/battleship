require './spec/spec_helper'

RSpec.describe MainMenu do
  before(:each) do
    @menu = MainMenu.new
  end

  it 'exists' do
    expect(@menu).to be_an_instance_of(MainMenu)
  end
  
  describe '#welcome message' do
    it 'has a welcome' do
      expect(@menu.welcome).to eq("Welcome to BATTLESHIP! \nEnter p to play or q to quit")
    end
  end

  describe '#start of game' do
    it 'asks the player to play' do 
      allow(@menu).to receive(:gets).and_return("p")
      allow(@menu).to receive(:choose_board_size)
      expect(@menu.start_game).to eq(true)
    end

    it '...or quit' do
      allow(@menu).to receive(:gets).and_return("q")
      expect(@menu.start_game).to eq("Sorry to see you go.")
    end
  end

  describe '#choose board size' do
    it 'sets the board size to 8' do
      allow(@menu).to receive(:gets).and_return("2")
      @menu.choose_board_size
      expect(@menu.board_size).to eq(8)
    end

    it 'sets the board size to 20' do
      allow(@menu).to receive(:gets).and_return("4")
      @menu.choose_board_size
      expect(@menu.board_size).to eq(20)
    end
  end

  describe '#ship placement' do
    before(:each) do
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
      @board = Board.new
    end

    it 'has placement instructions' do
      instructions = "I have laid out my ships on the grid.\n" +
                      "You now need to lay out your ships.\n" +                      
                      "  1  2  3  4\n" +
                      "A .  .  .  . \n" +
                      "B .  .  .  . \n" +
                      "C .  .  .  . \n" +
                      "D .  .  .  . \n"
      expect(@menu.placement_instructions).to eq(instructions)
    end

    it 'asks user to enter coorinates for cruiser' do
      allow(@menu).to receive(:gets).and_return("A1 A2 A3")
      expect(@menu.place_ship(@cruiser, @board)).to be true
      expect(@board.cells["A1"].ship).to eq(@cruiser)
      expect(@board.cells["A2"].ship).to eq(@cruiser)
      expect(@board.cells["A3"].ship).to eq(@cruiser)
    end

    it 'has a ship placement error' do
      allow(@menu).to receive(:gets).and_return("C1", "C4")
      expect(@menu.place_ship(@submarine, @board)).to eq("Those coordinates are invalid")
    end
  end
end