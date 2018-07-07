class Zombie
  SPEED = 2
  def initialize(window)
    @radius = 20
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @image = Gosu::Image.new('images/balloon-zombie-scaled.png')
  end

  def move
    @y += SPEED
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end
end