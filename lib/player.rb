class Player
  attr_accessor :name, :life_points

  def initialize(name, life_points = 10)
    @name = name
    @life_points = life_points
  end

  def show_state
    puts "Le joueur #{@name} a #{@life_points} point#{@life_points>1 ? "s" : ""} de vie"
  end

  def get_damage(damage)
    @life_points -= damage
    if @life_points <= 0
      puts "Le joueur #{@name} a été tué !"
      puts"           Y
           |      .
           +._ O /
           |  `#'
           |  / \\
              ())
              d b

               p
            .-/-o
           / /'
      .--./ /     --------<
          O'-._
               `"
    end
  end

  def attack(player)
    puts "le joueur #{@name} attaque le joueur #{player.name}"
    damage = compute_damage
    puts "il lui inflige #{damage} points de dommages"
    puts ""
    player.get_damage(damage)
  end

  def compute_damage
    return rand(1..6)
  end

  def self.next_attack
    puts ">>>Passons à la phase d'attaque :"
    puts "       ___/________"
    puts "         /    \\  \\"
    puts "    @___/      \\@/"
    puts "   /\\__/        |"
    puts "  / \\ /        / \\"
    puts "_/__/__________|__\\__"
  end
end




class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name, life_points = 100, weapon_level = 1)
    super(name, life_points)
    @weapon_level = weapon_level
  end

  def show_state
    puts "Le joueur #{@name} a #{@life_points} point#{@life_points>1 ? "s" : ""} de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    level_weapon_found = rand(1..6)
    puts "tu as trouvé une arme de niveau #{level_weapon_found}"
    if level_weapon_found > @weapon_level
      @weapon_level = level_weapon_found
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    health_pack_found = rand(1..6)
    if health_pack_found == 1
      puts "Tu n'as rien trouvé ..."
    elsif health_pack_found.between?(2,5)
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      if @life_points > 50
        puts "Tu es maintenant full-life"
        @life_points = 100
      else
        @life_points += 50
        puts "Tu as donc #{@life_points} point de vie maintenant"
      end
    else
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
      if @life_points > 20
        puts "Tu es maintenant full-life"
        @life_points = 100
      else
        @life_points += 80
        puts "Tu as donc #{@life_points} point de vie maintenant"
      end
    end
  end

  def self.weapon
    puts ">>>
,_._._._._._._._._|__________________________________________________________,
|_|_|_|_|_|_|_|_|_|_________________________________________________________/
                  !"
  end

  def self.heal
    puts ">>>
       +++++++
       +:::::+              /~ .~\\    /~  ~\\
       +:::::+             '      `\\/'      *
 +++++++:::::+++++++      (                .*)
 +:::::::::::::::::+       \\            . *./
 +:::::::::::::::::+        `\\ .      . .*/'
 +++++++:::::+++++++          `\\ * .*. */'
       +:::::+                  `\\ * */'
       +:::::+                    `\\/'
       +++++++       "
  end
end
