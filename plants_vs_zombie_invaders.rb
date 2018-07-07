require 'gosu'
require_relative 'plant'
require_relative 'zombie'

WIDTH = 800
HEIGHT = 600

class PlantsVsZombieInvaders < Gosu::Window
  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Plants vs. Zombie Invaders!'
    @plant = Plant.new(self)
    @zombie = Zombie.new(self)
  end

  def draw
    @plant.draw
    @zombie.draw
  end

  def update
    @plant.turn_left if button_down?(Gosu::KbLeft)
    @plant.turn_right if button_down?(Gosu::KbRight)
    @plant.accelerate if button_down?(Gosu::KbUp)
    @plant.move
    @zombie.move
  end
end

window = PlantsVsZombieInvaders.new
window.show