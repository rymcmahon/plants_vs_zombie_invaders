require 'gosu'
require_relative 'player'

WIDTH = 800
HEIGHT = 600

class PlantsVsZombieInvaders < Gosu::Window
  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Plants vs. Zombie Invaders!'
    @player = Player.new(self)
  end

  def draw
    @player.draw
  end

  def update
    @player.turn_left if button_down?(Gosu::KbLeft)
    @player.turn_right if button_down?(Gosu::KbRight)
    @player.accelerate if button_down?(Gosu::KbUp)
    @player.move

  end
end

window = PlantsVsZombieInvaders.new
window.show