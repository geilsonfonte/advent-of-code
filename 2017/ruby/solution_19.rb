input = File.read('../input/19.txt')


maze = input.lines.map(&:chars)
UP = [-1, 0]
DOWN = [1, 0]
LEFT = [0, -1]
RIGHT = [0, 1]

pos = [0, maze[0].index('|')]
dir = DOWN
letters = []
moves = 0

def move(pos, dir)
  [pos[0] + dir[0], pos[1] + dir[1]]
end

def char_at(pos, maze)
  maze[pos[0]][pos[1]] if maze[pos[0]]
end

while true do
  moves += 1
  pos = move(pos, dir)
  cell = char_at(pos, maze)
  case cell
  when ' '
    break
  when /[A-Z]/
    letters << cell
  when '+'
    if [UP, DOWN].include?(dir)
      left = move(pos, LEFT)
      left_cell = char_at(left, maze)
      dir = (left_cell and left_cell =~ /[-|]/) ? LEFT : RIGHT
    else
      up = move(pos, UP)
      up_cell = char_at(up, maze)
      dir = (up_cell and up_cell =~ /[-|]/) ? UP : DOWN
    end
  end
end

result1 = letters.join

result2 = moves

puts result1, result2
