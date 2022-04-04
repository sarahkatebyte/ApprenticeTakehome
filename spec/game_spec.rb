require "game"

RSpec.describe Game do
  let(:game) {Game.new}

  describe '#correct_guess?' do
    context 'when the given guess is in the codeword' do
      it 'should return true' do
        game.instance_variable_set(:@codeword, "codecademy")
        expect(game.correct_guess?("c")).to eq(true)
      end
    end

    context 'when the given guess is not in the codeword' do
      it 'should return false' do
        game.instance_variable_set(:@codeword, "codecademy")
        expect(game.correct_guess?("v")).to eq(false)
      end
    end
  end
end