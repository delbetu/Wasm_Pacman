class Hero
  include Moveable
  HEIGHT = 32.freeze
  WIDTH = 32.freeze
  SPEED_X = 2
  SPEED_Y = 2
  SPRITE = "./assets/sprite.png".freeze

  def initialize(x, y, canvas, context)
    @canvas = canvas
    @context = context
    @frame_col = 0
    @frame_row = 1
    @frame_sequence = circular(from: 0, to: 2)
    movable_setup(
      x,
      y,
      SPEED_X,
      SPEED_Y,
      WIDTH,
      HEIGHT,
      canvas,
      on_direction_change: method(:set_sprite_row)
    )
  end

  def increment_sprite_col
    every(0.2) do # open/close mouth
      @frame_col = @frame_sequence.()
    end
  end

  # called by movable when direction changes
  def set_sprite_row(direction)
    case direction
    when :left
      @frame_row = 0
    when :right
      @frame_row = 1
    when :up
      @frame_row = 2
    when :down
      @frame_row = 3
    end
  end

  def draw
    increment_sprite_col
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

  # circular(from: 4, to: 9) ==> loops through 4 to 9 each time it is called
  def circular(from: 0, to:)
      frame_col = from - 1
      ->() { from + (frame_col += 1) % (to - from + 1) }
  end
end
