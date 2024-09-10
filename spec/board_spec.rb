require './spec/spec_helper'

RSpec.describe Board do
    before(:each) do
      @board = Board.new
      @board2 = Board.new(8) 
    end

    describe '#initialize board' do
        it 'exisits' do
            expect(@board).to be_an_instance_of(Board)
        end

        it 'is a hash' do
            expect(@board.cells).to be_a(Hash)
        end

        it 'is not empty' do
            expect(@board.cells).not_to be_empty
        end

        it 'has 16 cells' do
            expect(@board.cells.size).to eq(16)
            expect(@board2.cells.size).to eq(64)
        end 

        it 'has Cell objects as values' do
            @board.cells.values.each do |cell| 
                expect(cell). to be_a(Cell)
            end
        end
    end

    describe '#can validate coordinates' do
        it 'can tell us if a coordinate is on the board' do
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
            @submarine = Ship.new("Submarine", 2)
        end

        it 'should have number of coordinates in the array equal to length of ship' do
            expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)            
        end

        it 'should have consecutive coordinates' do
            expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
            expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)

        end

        it 'should not be placed diagonally' do
            expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
        end

        it 'should be placed correctly' do
            expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
            expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
        end
    end

    describe '#place' do
        before(:each) do
            @cruiser = Ship.new("Cruiser", 3)
            @submarine = Ship.new("Submarine", 2)
        end

        it 'can place a ship' do
            expect(@board.place(@cruiser, ["A1", "A2", "A3"])).to eq true
            expect(@board.cells["A1"].ship).to eq(@cruiser)
            expect(@board.cells["A2"].ship).to eq(@cruiser)
            expect(@board.cells["A3"].ship).to eq(@cruiser)
        end

        it 'does not place ships on invalid coordinates' do
            expect(@board.place(@cruiser, ["A1", "A2", "B1"])).to be false
            expect(@board.cells["A1"].ship).to be_nil
            expect(@board.cells["A2"].ship).to be_nil
            expect(@board.cells["A4"].ship).to be_nil
        end

        it 'will not allow overlapping ships' do
            @board.place(@cruiser, ["A1", "A2", "A3"])
            expect(@board.place(@submarine, ["A1", "B1"])).to be false
        end
    end

    describe '#render' do
        before(:each) do
            @cruiser = Ship.new("Cruiser", 3)
            @submarine = Ship.new("Submarine", 2)
        end

        it 'renders the board without revealing ships by default' do
            expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
        end

        it 'renders the board with ships if show_ships = true' do
            @board.place(@cruiser, ["A1", "A2", "A3"])
            expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
        end

        it 'renders hits, misses, and sunken ships' do
            @board.place(@cruiser, ["A1", "A2", "A3"])
            @board.place(@submarine, ["C1", "D1"])
            @board.cells["A1"].fire_upon
            @board.cells["B4"].fire_upon
            @board.cells["C1"].fire_upon
            @board.cells["D1"].fire_upon
            expect(@board.render(true)).to eq("  1 2 3 4 \nA H S S . \nB . . . M \nC X . . . \nD X . . . \n")
        end

        it 'renders letter coordinates' do
            expect(@board.top_row).to eq("  1 2 3 4 \n")
        end

        it 'renders number coordinates' do
            expect(@board.board_numbers).to eq([1, 2, 3, 4])
        end
    end
end