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
    @current_frame = 1
    height = width = 16
    super(x, y, 2, 2, width, height, canvas)
  end

  def draw_sprite
    # open/close mouth
    every(0.2) do
      @current_frame = ( @current_frame + 1 ) % 3
    end
  end

  def draw
    draw_sprite
    image = JS.eval("return new Image()")
    image[:src] = "./assets/sprite.png"
    @context.drawImage(
      image,
      @current_frame * width,
      0, width, height, @x, @y, width, height
    )
  end

  # TODO: Move to utils ?
  def every(seconds)
    @animate_time ||= Time.now
    elapsed = Time.now - @animate_time
    if elapsed > seconds
      # restart timer
      @animate_time = Time.now

      yield
    end
  end
end

