# frozen_string_literal: true

# create Game class
class Game
  # variable accessible in the class
  attr_accessor :human_player, :enemies, :enemies_in_sight
  attr_accessor :players_left, :enemies_tot

  # initialize a game with a name and number of enemies (default value = 4)
  def initialize(name, number_enemies = 10)
    @human_player = HumanPlayer.new(name)
    @enemies = Array.new(number_enemies) { |i| "bot_#{i}" }.map do |bot|
      Player.new("#{bot}.to_s")
    end
    @players_left = number_enemies
    @enemies_tot = number_enemies
    @enemies_in_sight = []
  end

  # delete from enemies list when he is dead
  def kill_player(dead)
    @enemies_in_sight.delete(dead)
  end

  # check if the game is finish or not
  def is_still_ongoing?
    @human_player.life_points.positive? &&
      (!@enemies_in_sight.empty? || @players_left.positive?)
  end

  # show statistics of the game life point of player and number of alive enemies
  def show_players
    print '>>>'
    @human_player.show_state
    print "Il reste #{@enemies_in_sight.length} ennemis en vue"
    puts "+ #{@players_left} qui arrivent"
  end

  # show what the player can choice
  def menu
    puts '>>> Quelle action veux-tu effectuer ?

    a - chercher une meilleure arme
    s - chercher à se soigner

    '
    puts ' attaquer un joueur en vue : ' unless @enemies_in_sight.empty?
    @enemies_in_sight.each do |bot|
      print "#{@enemies_in_sight.index(bot)} - "
      print "#{bot.show_state}"
    end
  end

  # check if the choice is valide
  def valide_choice?(choice)
    valide_choice_array = %w[a s]
    @enemies_in_sight.each do |bot|
      valide_choice_array << @enemies_in_sight.index(bot).to_s
    end
    valide_choice_array.include?(choice)
  end

  # do the action chose
  def menu_choice
    choice = gets.chomp.to_s

    until valide_choice?(choice)
      puts "je n'ai pas compris ton choix"
      print '>>>'
      choice = gets.chomp.to_s
    end

    if choice == 'a'
      HumanPlayer.weapon
      @human_player.search_weapon
    elsif choice == 's'
      HumanPlayer.heal
      @human_player.search_health_pack
    else
      Player.next_attack
      @human_player.attack(@enemies_in_sight[choice.to_i])
      if @enemies_in_sight[choice.to_i].life_points <= 0
        kill_player(@enemies_in_sight[choice.to_i])
      end
    end
  end

  # all enemies attack the player
  def enemies_attack
    print '>>>'
    if @enemies_in_sight.empty?
      print "Il n'y a pas d'ennemis en vue tu n'es donc pas attaqué"
      puts '... pour cette fois'
    end
    @enemies_in_sight.each { |bot| bot.attack(@human_player) }
  end

  # the end of the game win ? or loose ?
  def end_game
    puts 'La partie est finie'
    if @human_player.life_points.positive?
      puts 'BRAVO ! TU AS GAGNÉ !'
      trophy
    else
      puts 'Loser ! Tu as perdu !'
      loose
    end
  end

  # add player on sight
  def new_players_in_sight
    puts '>>> Tous les joueurs sont déjà en vue' if @players_left.zero?
    if @players_left.positive?
      dice = rand(1..6)
      if dice == 1
        puts ">>> Tu as de la chance il n'y a pas de nouvel adversaire en plus"
      elsif dice.between?(2, 4)
        @enemies_in_sight << Player.new("bot_#{@enemies_tot - @players_left}")
        @players_left -= 1
        puts ">>> Tu as un nouvel adversaire #{enemies_in_sight[-1].name}"
      elsif dice > 4
        2.times do
          @enemies_in_sight << Player.new("bot_#{@enemies_tot - @players_left}")
          @players_left -= 1
        end
        print '>>> Pas de chance, tu as 2 nouveaux adversaires '
        puts "#{enemies_in_sight[-1].name} et #{enemies_in_sight[-2].name}"
      end
    end
  end

  # message if you win
  def trophy
    puts "
                                                       .-=========-.
                                                       \\'-=======-'/
__  __                        _                        _|   .=.   |_
\\ \\/ /___  __  __   _      __(_)___                   ((|  {{1}}  |))
 \\  / __ \\/ / / /  | | /| / / / __ \\                   \\|   /|\\   |/
 / / /_/ / /_/ /   | |/ |/ / / / / /                    \\__ '`' __/
/_/\\____/\\__,_/    |__/|__/_/_/ /_/                       _`) (`_
                                                        _/_______\\_
                                                       /___________\\ "
  end

  # message if loose
  def loose
    puts "
                                                                         ,____
                                                                 ___     |---.\\
                                                                / .-\\  ./=)   '
                                                               |  |\"|_/\\/|
                                                               ;  |-;| /_|
__  __               __                                       / \\_| |/ \\ |
\\ \\/ /___  __  __   / /___  ____  ________                   /      \\/\\( |
 \\  / __ \\/ / / /  / / __ \\/ __ \\/ ___/ _ \\                  |   /  |` ) |
 / / /_/ / /_/ /  / / /_/ / /_/ (__  )  __/                  /   \\ _/    |
/_/\\____/\\__,_/  /_/\\____/\\____/____/\\___/                  /--._/  \\    |
                                                            `/|)    |    /
                                                              /     |   |
                                                            .'      |   |
                                                           /         \\  |
                                                          (_.-.__.__./  /
"
  end
end
