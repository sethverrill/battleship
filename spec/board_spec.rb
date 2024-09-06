require './spec/spec_helper'

RSpec.describe Board do
    before(:each) do
      @board = Board.new  
    end

    it 'exisits' do
        expect(@board).to be_an_instance_of(Board)
    end

    it 'is a hash' do
        expect(@board.cells).to be_a(Hash)
    end

    it 'is not empty' do
        expect(@baord.cells).not_to be_empty
    end

    it 'has 16 cells' do
        expect(@board.cells.size) to eq(16)
    end 

    it 'has Cell objects as values' do
        @board.cells.values.each do |cell| 
            expect(cell). to be_a(Cell)
        end
    end
end