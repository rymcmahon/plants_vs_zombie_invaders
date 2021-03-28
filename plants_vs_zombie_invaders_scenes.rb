require 'gosu'
require_relative 'plant'
require_relative 'zombie'
require_relative 'bullet'
require_relative 'explosion'

class PlantsVsZombieInvaders < Gosu::Window
  attr_reader :zombies_spawned, :zombies_destroyed, :shots_fired, :hit_rate

  WIDTH = 1400
  HEIGHT = 600
  ZOMBIE_FREQUENCY = 0.015
  
  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Plants vs. Zombie Invaders!'
    @background_image = Gosu::Image.new('images/lawn-background.png')
    @scene = :start
  end

  def initialize_game
    @plant = Plant.new(self)
    @zombies = []
    @bullets = []
    @explosions = []
    @font = Gosu::Font.new(15)
    @scene = :game
    @zombies_destroyed = 0
    @shots_fired = 0
    @zombies_spawned = 0
    @hit_rate = 0.00
  end

  def draw
    case @scene
    when :start
      draw_start
    when :game
      draw_game
    when :end
      draw_end
    end
  end

  def draw_start
    @background_image.draw(0,0,0)
  end

  def button_down(id)
    case @scene
    when :start
      button_down_start(id)
    when :game
      button_down_game(id)
    when :end
      button_down_end(id)
    end
  end

  def button_down_start(id)
    initialize_game
  end

  def update
    case @scene
    when :game
      update_game
    when :end
      update_end
    end
  end

  def update_game
    @plant.turn_left if button_down?(Gosu::KbLeft)
    @plant.turn_right if button_down?(Gosu::KbRight)
    @plant.accelerate if button_down?(Gosu::KbUp)
    @plant.move
    if rand < ZOMBIE_FREQUENCY
      @zombies.push Zombie.new(self)
      @zombies_spawned += 1
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
          @zombies_destroyed += 1
        end
        calculate_hit_rate(@zombies_destroyed, @shots_fired)
      end
    end
  end

  def button_down_game(id)
    if id == Gosu::KbSpace
      @bullets.push Bullet.new(self, @plant.x, @plant.y, @plant.angle)
      @shots_fired += 1
    end
    calculate_hit_rate(@zombies_destroyed, @shots_fired)
  end

  def draw_game
    @background_image.draw(0,0,0)
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
    @font.draw_text("Zombies Spawned: #{@zombies_spawned.to_s}", 1205, 20, 2, 1, 1, 0xff_ffffff)
    @font.draw_text("Zombies Destroyed: #{@zombies_destroyed.to_s}", 1205, 40, 2, 1, 1, 0xff_ffffff)
    @font.draw_text("Shots Fired: #{@shots_fired.to_s}", 1205, 60, 2, 1, 1, 0xff_ffffff)
    @font.draw_text("Hit Rate: #{@hit_rate}%", 1205, 80, 2, 1, 1, 0xff_ffffff)
    Gosu.draw_rect(1200, 10, 150, 100, 0xB3_000000, 1, mode=:default)
  end
  
  def calculate_hit_rate(zombies_destroyed, shots_fired)
    if @shots_fired > 0
      @hit_rate =  (@zombies_destroyed.to_f / @shots_fired.to_f * 100.00).round(2)
    else
      @hit_rate = 0.00
    end
  end

  def draw_end

  end
end

window = PlantsVsZombieInvaders.new
window.show