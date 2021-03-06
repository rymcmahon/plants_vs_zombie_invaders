require 'gosu'
require_relative 'plant'
require_relative 'zombie'
require_relative 'bullet'
require_relative 'explosion'

class PlantsVsZombieInvaders < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ZOMBIE_FREQUENCY = 0.015

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Plants vs. Zombie Invaders!'
    @plant = Plant.new(self)
    @zombies = []
    @bullets = []
    @explosions = []
  end

  def draw
    @plant.draw
    @zombies.each do |zombie|
      zombie.draw
    end
    @bullets.each do |bullet|
      bullet.draw
    end
    @explosions.each do |explosion|
      explosion.draw
    end
  end

  def update
    @plant.turn_left if button_down?(Gosu::KbLeft)
    @plant.turn_right if button_down?(Gosu::KbRight)
    @plant.accelerate if button_down?(Gosu::KbUp)
    @plant.move
    if rand < ZOMBIE_FREQUENCY
      @zombies.push Zombie.new(self)
    end
    @zombies.each do |zombie|
      zombie.move
    end
    @bullets.each do |bullet|
      bullet.move
    end
    @zombies.dup.each do |zombie|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(zombie.x, zombie.y, bullet.x, bullet.y)
        if distance < zombie.radius + bullet.radius
          @zombies.delete zombie
          @bullets.delete bullet
          @explosions.push Explosion.new(self, zombie.x, zombie.y)
        end
      end
    end
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @bullets.push Bullet.new(self, @plant.x, @plant.y, @plant.angle)
    end
  end
end

window = PlantsVsZombieInvaders.new
window.show