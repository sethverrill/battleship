require './spec/spec_helper'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    
  end

  it 'exists' do
    expect(@cell).to be_an_instance_of(Cell)
  end

  it 'has a coordinate' do
    expect(@cell.coordinate).to eq("B4")
  end

  it 'has no ships to start' do
    expect(@cell.ship).to eq(nil)
  end

  it 'returns true if cell is empty' do
    expect(@cell.empty?).to eq(true)
  end

  it 'returns false if a ship is placed' do
    @cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(@cruiser)
    expect(@cell.empty?).to eq(false)
  end

  #new describe method for firing?

  it 'knows if it has been fired upon' do
    @cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(@cruiser)
    expect(@cell.fired_upon?).to eq(false)

    @cell.fire_upon
    expect(@cruiser.health).to eq(2)
    expect(@cell.fired_upon?).to eq(true)
  end

  it 'renders a location' do    
    expect(@cell.render).to eq(".")    
    @cell.fire_upon
    expect(@cell.render).to eq("M")    
  end

  it 'can place a ship and recognize it' do
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
    @cell_2.place_ship(@cruiser)
    expect(@cell_2.render).to eq(".")
    expect(@cell_2.render(true)).to eq("S")
  end

  it 'can be fired upon' do
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    expect(@cell_2.render).to eq("H")
  end

  it 'displays if it has been sunk' do
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    expect(@cruiser.sunk?).to eq(false)
    @cruiser.hit
    expect(@cell_2.render).to eq("H")
    @cruiser.hit  
    expect(@cruiser.sunk?).to eq(true)
    expect(@cell_2.render).to eq("X")
  end

end