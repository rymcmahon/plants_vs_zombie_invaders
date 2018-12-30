class Zombie
  attr_reader :x, :y, :radius

  def initialize(window)
    @speed = rand(2..7)
    @radius = 65
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @image = Gosu::Image.new('images/balloon-zombie-scaled.png')
  end

  def move
    @y += @speed
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end
end