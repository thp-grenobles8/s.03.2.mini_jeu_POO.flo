 require 'bundler'
 Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


player1= Player.new("Josiane")
player2= Player.new("José")
while player1.life_points > 0 && player2.life_points >0
  puts "Voici l'état de chauqe joueur"
  puts "   #{player1.name} a #{player1.life_points} points de vie"
  puts "   #{player2.name} a #{player2.life_points} points de vie"
  Player.next_attack

  player1.attack(player2)
  if player2.life_points >0
    player2.attack(player1)
  end
  puts "----------------------------"
end

# player2.show_state
#binding.pry
