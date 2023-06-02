require 'js'

class Hero
  def initialize(x,y, canvas, context)
    @x = x
    @y = y
    @canvas = canvas
    @context = context
    @xd = @yd = 2
    @width = 50
    @height = 50
  end

  def move(direction)
    case direction
    when :left
      @x -= @xd if within_limits?(@x - @xd, @y)
    when :right
      @x += @xd if within_limits?(@x + @xd, @y)
    when :up
      @y -= @yd if within_limits?(@x, @y - @yd)
    when :down
      @y += @yd if within_limits?(@x, @y + @yd)
    end
  end

  def within_limits?(x, y)
    before_right_limit = x + @width <= @canvas[:width].to_i
    after_left_limit = x >= 0
    before_bottom_limit = y + @height <= @canvas[:height].to_i
    after_top_limit = y >= 0

    before_right_limit && after_left_limit && before_bottom_limit && after_top_limit
  end

  def draw
    @context[:fillStyle] = 'red'
    @context.fillRect(@x, @y, @width, @height)
  end
end

