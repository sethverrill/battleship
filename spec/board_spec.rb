require './spec/spec_helper'

RSpec.describe Board do
    before(:each) do
      @board = Board.new  
    end

    describe '#initialize board' do
        xit 'exisits' do
            expect(@board).to be_an_instance_of(Board)
        end

        xit 'is a hash' do
            expect(@board.cells).to be_a(Hash)
        end

        xit 'is not empty' do
            expect(@baord.cells).not_to be_empty
        end

        xit 'has 16 cells' do
            expect(@board.cells.size).to eq(16)
        end 

        xit 'has Cell objects as values' do
            @board.cells.values.each do |cell| 
                expect(cell). to be_a(Cell)
            end
        end
    end

    describe '#can validate coordinates' do
        xit 'can tell us if a coordinate is on the board' do
            expect(@board.valid_coordinate?("A1")).to eq(true)
            expect(@board.valid_coordinate?("D4")).to eq(true)
            expect(@board.valid_coordinate?("A5")).to eq(false)
            expect(@board.valid_coordinate?("E1")).to eq(false)
            expect(@board.valid_coordinate?("A22")).to eq(false)
        end
    end

    describe '#can validate ship placements' do
        before(:each) do
            @cruiser = Ship.new("Cruiser", 3)
            @submarine = Ship.new("Submarine, 2")
        end

            xit 'should have number of coordinates in the array equal to length of ship' do
                expect(@board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
                board.valid_placement?(submarine, ["A2", "A3", "A4"]).to eq(false)
            end

            xit 'should have consecutive coordinates' do
                expect(@board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
                expect(@board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
                expect(@board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
                expect(@board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
            end

            xit 'should not be placed diagonally' do
                expect(@board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
                expect(@board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
            end

            xit 'should be placed correctly' do
                expect(@board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
                expect(@board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
            end
    end
end