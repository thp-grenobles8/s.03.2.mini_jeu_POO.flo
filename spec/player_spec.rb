# frozen_string_literal: true

require_relative '../lib/player.rb'
require_relative '../lib/game.rb'

# test Player class
describe 'Player class' do
  player = Player.new('henry')
  # test on initialize
  describe 'initialize correctly' do
    it 'name and life point' do
      expect(player.name).to eq('henry')
      expect(player.life_points).to eq(10)
    end
  end

  # test on get damage
  describe 'get damage' do
    it 'correct get damage' do
      player.get_damage(5)
      expect(player.life_points).to eq(5)
    end
  end

  # test on compute damage
  describe 'compute_damage' do
    test = []
    100.times do
      test << player.compute_damage
    end
    it 'compute correctly damage' do
      expect(test.min >= 1).to eq(true)
      expect(test.max <= 6).to eq(true)
    end
  end
end

# test on HumanPlayer class
describe 'HumanPlayer class' do
  player = HumanPlayer.new('henry')
  # test on initialization
  describe 'initialize correctly' do
    it 'name, life point and weapon-level' do
      expect(player.name).to eq('henry')
      expect(player.life_points).to eq(100)
      expect(player.weapon_level).to eq(1)
    end
  end

  # test on compute damage with weapon level
  describe 'compute damage' do
    it 'compute damage correctly' do
      player.weapon_level = 2
      test = []
      100.times do
        test << player.compute_damage
      end
      expect(test.min >= 2).to eq(true)
      expect(test.max <= 12).to eq(true)
    end
  end
end
