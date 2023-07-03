class Block
  include Drawable
  HEIGHT = 32.freeze
  WIDTH = 32.freeze
  SPRITE = "./assets/block.png".freeze

  def initialize(x, y, canvas, context)
    @canvas = canvas
    @context = context
    @frame_col = 0
    @frame_row = 0
    drawable_setup(x, y, WIDTH, HEIGHT, canvas)
  end

  def draw
    image = JS.eval("return new Image()")
    image[:src] = SPRITE
    @context.drawImage(
      image,
      ( @frame_col * width ),# start x
      ( @frame_row * height ), # start y
      width, # width x
      height, # height y
      @x,
      @y,
      width,
      height
    )
  end
end
