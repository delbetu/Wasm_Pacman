require 'js'

module Moveable
  attr_accessor :x, :y, :speed_x, :speed_y, :width, :height
  def initialize(x, y, speed_x, speed_y, width, height, canvas)
    @x = x
    @y = y
    @speed_x = speed_x
    @speed_y = speed_y
    @width = width
    @height = height
    @canvas = canvas
  end

  def move(direction)
    case direction
    when :left
      @x -= @speed_x if within_limits?(@x - @speed_x, @y)
    when :right
      @x += @speed_x if within_limits?(@x + @speed_x, @y)
    when :up
      @y -= @speed_y if within_limits?(@x, @y - @speed_y)
    when :down
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

class Hero
  include Moveable
  def initialize(x,y, canvas, context)
    @canvas = canvas
    @context = context
    super(x, y, 2, 2, 50, 50, canvas)
  end

  def draw
    @context[:fillStyle] = 'red'
    @context.fillRect(@x, @y, @width, @height)
  end
end

