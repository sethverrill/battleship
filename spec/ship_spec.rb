require './spec/spec_helper'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end

  #let me know if you want to break these up with "it 'describe' do in sections"
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
  end

  #another describe here if we want to make that uniform
  it 'returns false if ship is not sunk' do
    expect(@cruiser.sunk?).to eq(false)
  end  

  it 'loses health on hit' do
    @cruiser.hit
    expect(@cruiser.health).to eq(2)
    @cruiser.hit
    expect(@cruiser.health).to eq(1)
  end

  xit 'returns true if ship is sunk' do
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    expect(@cruiser.sunk?).to eq(true)
  end
end