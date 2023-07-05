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

  def move(direction, walls)
    case direction
    when :left
      direction_change_handler.call(:left)
      @x -= @speed_x if no_collision?(@x - @speed_x, @y, walls)
    when :right
      direction_change_handler.call(:right)
      @x += @speed_x if no_collision?(@x + @speed_x, @y, walls)
    when :up
      direction_change_handler.call(:up)
      @y -= @speed_y if no_collision?(@x, @y - @speed_y, walls)
    when :down
      direction_change_handler.call(:down)
      @y += @speed_y if no_collision?(@x, @y + @speed_y, walls)
    end
  end

  def no_collision?(new_x, new_y, walls)
    !walls.collision?(new_x, new_y, @width, @height)
  end
end
