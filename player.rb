class Player
  def initialize(window)
    @x = 200
    @y = 200
    @angle = 0
    @image = Gosu::Image.new('images/lava-guava.png')
    @velocity_x = 0
    @velocity_y = 0
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def turn_right
    @angle += 3
  end
  def turn_left
    @angle -= 3
  end
end