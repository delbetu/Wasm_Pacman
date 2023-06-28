# Represents an shape within a canvas
# Shapes cannot overlap with each other
module Drawable
  attr_accessor :x, :y, :width, :height
  def drawable_setup(x, y, width, height, canvas)
    @x = x
    @y = y
    @width = width
    @height = height
    @canvas = canvas
  end
end

