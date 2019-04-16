# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# initialize Game
player1 = Player.new('Josiane')
player2 = Player.new('José')

# Game loop
while player1.life_points.positive? && player2.life_points.positive?
  puts "Voici l'état de chauqe joueur"
  puts "   #{player1.name} a #{player1.life_points} points de vie"
  puts "   #{player2.name} a #{player2.life_points} points de vie"
  Player.next_attack

  player1.attack(player2)
  player2.attack(player1) if player2.life_points.positive?
  puts '----------------------------'
end
