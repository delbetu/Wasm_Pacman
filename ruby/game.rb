require 'js'

FPS = 60.freeze
canvas = JS.global[:document].querySelector('#myCanvas')
@max_width = 400 - 50
@max_height = 400 - 50
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

def move_rectangle_left = @x = [ @x - @speedX, 0 ].max
def move_rectangle_right = @x = [ @x + @speedX, @max_width ].min
def move_rectangle_top = @y = [ @y - @speedY, 0].max
def move_rectangle_bottom = @y = [ @y + @speedY, @max_height].min

def draw
  @ctx.clearRect(0,0, @max_width, @max_height)
  draw_rectangle
  move_rectangle_bottom
end

JS.global.setInterval(-> { draw }, TIME_PER_FRAME)
