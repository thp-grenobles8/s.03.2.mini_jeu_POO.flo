# frozen_string_literal: true

require_relative '../lib/player.rb'
require_relative '../lib/game.rb'

# test Game class
describe 'test Game class : methods enemies, life_points and kill_player' do
  game_test = Game.new('paul')
  it 'enemies' do
    expect(game_test.enemies.class == Array).to eq(true)
    expect(game_test.enemies.length).to eq(10)
  end

  it 'life points bots' do
    expect(game_test.enemies[0].life_points).to eq(10)
  end

  it 'life points player' do
    expect(game_test.human_player.life_points).to eq(100)
  end

  it 'kill player test' do
    game_test.enemies_in_sight = %w[bot1 bot2 bot3]
    expect(game_test.enemies_in_sight.length).to eq(3)
    game_test.kill_player('bot2')
    expect(game_test.enemies_in_sight.length).to eq(2)
  end
end

# try ongoing when it right
describe 'is still ongoing ? right' do
  game_test = Game.new('paul')
  game_test.human_player.life_points = 10
  it 'should ongoing unless no more player left' do
    game_test.enemies_in_sight = %w[bot1 bot2 bot3]
    game_test.players_left = 0
    expect(game_test.is_still_ongoing?).to eq(true)
  end
  it 'shoulde ongoing unless empty enemies in sight' do
    game_test.enemies_in_sight = []
    game_test.players_left = 2
    expect(game_test.is_still_ongoing?).to eq(true)
  end
end

# try still ongoin when it wrong
describe 'is still ongoing ? wrong' do
  game_test = Game.new('paul')
  it 'should stop because of player death' do
    game_test.human_player.life_points, game_test.players_left = 0
    game_test.enemies_in_sight = %w[bot1 bot2 bot3]
    game_test.players_left = 0
    expect(game_test.is_still_ongoing?).to eq(false)
  end
  it 'shoulde stop because of no more enemies' do
    game_test.human_player.life_points = 10
    game_test.enemies_in_sight = []
    game_test.players_left = 0
    expect(game_test.is_still_ongoing?).to eq(false)
  end
end
