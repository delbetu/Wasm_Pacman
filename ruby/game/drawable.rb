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

  def colliding?(other_x, other_y, other_width, other_height)
    horizontal_collision?(other_x, other_x + other_width) &&
      vertical_collision?(other_y, other_y + other_height)
  end

  def horizontal_collision?(other_start, other_end)
    !(
      other_start >= x + width || # other starts after this one
      other_end <= x              # other ends before this one
    )
  end

  def vertical_collision?(other_start, other_end)
    !(
      other_start >= y + height || # other starts after this one
      other_end <= y               # other ends before this one
    )
  end
end
