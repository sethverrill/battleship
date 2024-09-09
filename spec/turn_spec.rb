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
    
  describe '#displays the boards' do
    it "renders the player board" do
      expect(@turn.display_board).to eq()
    end
  end

  describe '#player makes a guess' do
    it "player chooses a coordinate to fire on" do
      expect(@turn.p_choose_coord).to eq()
    end
  end

  describe '#computer makes a guess' do
    it "computer chooses a coordiante to fire on" do
      expect(@turn.comp_choose_coord).to eq()
    end
  end
  
  describe "#gives feedback" do
    it "player had a hit"
      expect(@turn.)
    end

    it "player had a miss" do
      expect(@turn.)
    end

    it "computer had a hit" do
      expect(@turn.)
    end

    it "computer had a miss" do
      expect(@turn.)
    end
  end 
end