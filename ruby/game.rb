require 'js'

FPS = 60.freeze
canvas = JS.global[:document].querySelector('#myCanvas')
@ctx = canvas.getContext("2d")
TIME_PER_FRAME = (1000 / FPS).freeze
@x = 0
@y = 0
@speedX = 2
@speedY = 2

def draw_rectangle
  @ctx[:fillStyle] = 'red'
  @ctx.fillRect(@x, @y, 50, 50)
end

JS.global.setInterval(-> { draw_rectangle }, TIME_PER_FRAME)
