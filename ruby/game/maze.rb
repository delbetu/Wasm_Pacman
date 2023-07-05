# Positions each block in its place, forming the walls of the maze.
class Maze
  BLOCKS = %(
############################
#............##............#
#.####.#####.##.#####.####.#
#.####.#####.##.#####.####.#
#.####.#####.##.#####.####.#
#..........................#
#.####.##.########.##.####.#
#.####.##.########.##.####.#
#......##....##....##......#
######.#####.##.#####.######
######.#####.##.#####.######
######.##..........##.######
######.##.########.##.######
######.##.########.##.######
..........########..........
######.##.########.##.######
######.##.########.##.######
######.##..........##.######
######.##.########.##.######
######.##.########.##.######
#............##............#
#.####.#####.##.#####.####.#
#.####.#####.##.#####.####.#
#...##................##...#
###.##.##.########.##.##.###
###.##.##.########.##.##.###
#......##....##....##......#
#.##########.##.##########.#
#.##########.##.##########.#
#..........................#
############################).freeze

  def initialize(canvas, context)
    @blocks = []
    create_blocks(canvas, context)
  end

  def draw
    @blocks.each(&:draw)
  end

  def collision?(other_x, other_y, other_width, other_height)
    @blocks.any? {|block| block.colliding?(other_x, other_y, other_width, other_height)}
  end

  private

  def create_blocks(canvas, context)
    BLOCKS.split.each.with_index do |line, x|
      line.each_char.with_index do |char, y|
        if char == '#'
          @blocks.push(
            Block.new(x*Block::WIDTH, y*Block::HEIGHT, canvas, context)
          )
        end
      end
    end
  end
end
