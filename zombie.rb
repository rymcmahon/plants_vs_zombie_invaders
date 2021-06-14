class Zombie
  attr_reader :x, :y, :radius

  def initialize(window)
    @window = window
    @speed = rand(1..4)
    @radius = 65           
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @image = Gosu::Image.new(select_zombie)
    @velocity_x = rand(1..4)
    @velocity_y = rand(1..4)
  end

  def move
    @x += @velocity_x
    @y += @velocity_y
    if @x > 1400 || @x < 0
      @velocity_x *= -1
    end
    if @y > 600 || @y < 0
      @velocity_y *= -1
    end
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end

  def select_zombie
    zombies = ['images/rocket-pack-zombie.png', 'images/balloon-zombie.png', 'images/hoverboard-zombie.png', 'images/ostrich-zombie.png']
    zombies.sample
  end

  def remove(zombies)
    @zombies.dup.each do |zombie|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(zombie.x, zombie.y, bullet.x, bullet.y)
        if distance < zombie.radius + bullet.radius
          @zombies.delete zombie
          @bullets.delete bullet
          @explosion_sound.play
          @explosions.push Explosion.new(self, zombie.x, zombie.y)
          @zombies_destroyed += 1
        end
        calculate_hit_rate(@zombies_destroyed, @shots_fired)
      end
    end
  end
end