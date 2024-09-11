require './spec/spec_helper'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
    @dinghy = Ship.new("Dinghy", 1)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cruiser).to be_an_instance_of(Ship)
    end

    it 'has a name' do
      expect(@cruiser.name).to eq("Cruiser")
    end

    it 'has a length' do 
      expect(@cruiser.length).to eq(3)
    end

    it 'has a starting health' do
      expect(@cruiser.health).to eq(3)
      expect(@dinghy.health).to eq(1)
    end
  end

  describe '#health of ships' do
    it 'returns false if ship is not sunk' do
      expect(@cruiser.sunk?).to eq(false)
    end  

    it 'loses health on hit' do
      @cruiser.hit
      expect(@cruiser.health).to eq(2)
      @cruiser.hit
      expect(@cruiser.health).to eq(1)
    end

    it 'returns true if ship is sunk' do
      3.times {@cruiser.hit}
      @dinghy.hit      

      expect(@cruiser.sunk?).to eq(true)
      expect(@dinghy.sunk?).to eq(true)
    end

    it 'does not allow health below 0' do
      4.times {@cruiser.hit}

      expect(@cruiser.health).to eq(0)
      expect(@cruiser.sunk?).to eq(true)    
    end
  end

  describe '#build ships' do
    it 'builds default ships when user enters n' do
      allow(Ship).to receive(:gets).and_return("n\n")
      ships = Ship.build_ships
      expect(ships.map(&:name)).to include("Cruiser", "Submarine", "Dinghy")
    end

    it 'builds custom ships when user enters y' do
      allow(Ship).to receive(:gets).and_return("y\n", "Destroyer\n", "4\n", "done\n")
      
      ships = Ship.build_ships
      
      expect(ships.map(&:name)).to include("Destroyer")
      expect(ships.map(&:length)).to include(4)
    end

  end
end