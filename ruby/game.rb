require 'js'

FPS = 60.freeze
@canvas = JS.global[:document].querySelector('#myCanvas')
@ctx = @canvas.getContext("2d")
TIME_PER_FRAME = (1000 / FPS).freeze
@hero = Hero.new(0,0, @canvas, @ctx)

@pressed_keys = {up: false, down: false, left: false, right: false}

def update
  @hero.move(:down) if @pressed_keys[:down]
  @hero.move(:right) if @pressed_keys[:right]
  @hero.move(:up) if @pressed_keys[:up]
  @hero.move(:left) if @pressed_keys[:left]
end

def draw
  @ctx.clearRect(0,0, @canvas[:width].to_i, @canvas[:height].to_i)
  update
  @hero.draw
end

def disable_defaults
  # arrow keys and space have undesired behavior by default
  # lets disable that
  JS.global[:window].addEventListener("keydown", ->(evt) do
    case evt[:keyCode].to_i
    when 32,37,38,39,40 # space and arrows
      evt.preventDefault()
    end
  end, false)
end

def subscribe_events
  disable_defaults
  JS.global[:window].addEventListener("keydown", ->(evt) do
    case evt[:key].to_s
    when "ArrowLeft", "s"
      @pressed_keys[:left] = true
    when "ArrowRight", "f"
      @pressed_keys[:right] = true
    when "ArrowUp", "e"
      @pressed_keys[:up] = true
    when "ArrowDown", "d"
      @pressed_keys[:down] = true
    else
    end
  end, false)

  JS.global[:window].addEventListener("keyup", ->(evt) do
    case evt[:key].to_s
    when "ArrowLeft", "s"
      @pressed_keys[:left] = false
    when "ArrowRight", "f"
      @pressed_keys[:right] = false
    when "ArrowUp", "e"
      @pressed_keys[:up] = false
    when "ArrowDown", "d"
      @pressed_keys[:down] = false
    else
    end
  end, false)
end

subscribe_events
JS.global.setInterval(-> { draw }, TIME_PER_FRAME)
