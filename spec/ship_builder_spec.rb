require './spec/spec_helper'

RSpec.describe ShipBuilder do
  before(:each) do
    @builder = ShipBuilder.new
  end

  describe '#initialize' do
    it 'exits and is empty' do
      expect(@builder.ships).to eq([])
    end
  end

  describe '#build_ships' do
    it 'allows user to use default ships' do
      allow(@builder).to receive(:gets).and_return("n\n")
    end

    it 'creates default ships' do
      @builder.build_ships
      expect(@builder.ships).to have_attributes(
        length: 2, 
        names: ["Cruiser", "Submarine"], 
        lengths: [3, 2]
        )
      #do we want to have a third default ship? I remember Nick saying someone made a rubber duck in 2407
    end

    it 'allows user to create ships' do
      allow(@builder).to receive(:gets).and_return("y\n")
    end

    it 'can receive attributes for ships' do
      allow(@builder).to receive(:gets).and_return(
        "y\n",
        "Battleship\n", "4\n",
        "Carrier\n", "5\n",
        "done\n"
      )
      @builder.build_ships
    end

    it 'creates based on input' do
      expect(@builder.ships).to have_attributes(
        length: 2,
        names: ["Battleship", "Carrier"],
        lengths: [4, 3]
      )
    end

    it 'knows invalid input' do
      allow(@builder).to receive(:gets).and_return(
        "y\n",
        "BadShip\n", "0\n"
        "done\n"
      )
      @builder.build_ships
    end

    it 'handles invalid input' do
      #here I think we should have the invalid input result in default ships being used,
      #but if you think an error message that loops back to the start is better we can do that"
    end
  end
end