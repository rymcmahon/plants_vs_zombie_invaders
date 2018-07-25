require 'gosu'
require_relative 'plant'
require_relative 'zombie'


class PlantsVsZombieInvaders < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ZOMBIE_FREQUENCY = 0.015

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Plants vs. Zombie Invaders!'
    @plant = Plant.new(self)
    @zombies = []
  end

  def draw
    @plant.draw
    @zombies.each do |zombie|
      zombie.draw
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
  end
end

window = PlantsVsZombieInvaders.new
window.show