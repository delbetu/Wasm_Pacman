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

def move_rectangle_left = @x -= @speedX
def move_rectangle_right = @x += @speedX
def move_rectangle_top = @y -= @speedY
def move_rectangle_bottom = @y += @speedY

def draw
  @ctx.clearRect(0,0, 400, 400)
  draw_rectangle
  move_rectangle_bottom
end

JS.global.setInterval(-> { draw }, TIME_PER_FRAME)
