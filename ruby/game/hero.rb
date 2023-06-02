require 'js'

class Hero
  def initialize(x,y, canvas, context)
    @x = x
    @y = y
    @canvas = canvas
    @context = context
    @speedX = 2
    @speedY = 2
    @rectangle_width = 50
    @max_width = @canvas[:width].to_i - @rectangle_width
    @max_height = @canvas[:height].to_i - @rectangle_width
  end

  def move(direction)
    case direction
    when :left
      @x = [ @x - @speedX, 0 ].max
    when :right
      @x = [ @x + @speedX, @max_width ].min
    when :up
      @y = [ @y - @speedY, 0].max
    when :down
      @y = [ @y + @speedY, @max_height].min
    end
  end

  def draw
    @context[:fillStyle] = 'red'
    @context.fillRect(@x, @y, @rectangle_width, @rectangle_width)
  end
end

