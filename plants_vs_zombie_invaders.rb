require 'gosu'
require_relative 'player'

class PlantsVsZombieInvaders < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Plants vs. Zombie Invaders!'
    @player = Player.new(self)
  end

  def draw
    @player.draw
  end

  def update
    @player.turn_left if button_down?(Gosu::KbLeft)
    @player.turn_right if button_down?(Gosu::KbRight)
  end
end

window = PlantsVsZombieInvaders.new
window.show