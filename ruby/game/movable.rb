# implements move method incrementing possition of an element within a canvas
module Moveable
  include Drawable
  attr_accessor :speed_x, :speed_y
  attr_reader :direction_change_handler

  def movable_setup(x, y, speed_x, speed_y, width, height, canvas, on_direction_change: lambda {})
    @speed_x = speed_x
    @speed_y = speed_y
    @direction_change_handler = on_direction_change
    drawable_setup(x, y, width, height, canvas)
  end

  def move(direction)
    case direction
    when :left
      direction_change_handler.call(:left)
      @x -= @speed_x if within_limits?(@x - @speed_x, @y)
    when :right
      direction_change_handler.call(:right)
      @x += @speed_x if within_limits?(@x + @speed_x, @y)
    when :up
      direction_change_handler.call(:up)
      @y -= @speed_y if within_limits?(@x, @y - @speed_y)
    when :down
      direction_change_handler.call(:down)
      @y += @speed_y if within_limits?(@x, @y + @speed_y)
    end
  end

  def within_limits?(x, y)
    before_right_limit = x + @width <= @canvas[:width].to_i
    after_left_limit = x >= 0
    before_bottom_limit = y + @height <= @canvas[:height].to_i
    after_top_limit = y >= 0

    before_right_limit && after_left_limit && before_bottom_limit && after_top_limit
  end
end
