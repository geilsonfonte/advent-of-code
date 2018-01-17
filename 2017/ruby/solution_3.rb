input = File.read('../input/3.txt')

input_cell = input.to_i
last_square = Math.sqrt(input_cell).floor
square_distance = last_square - 1
horizontal_square_distance = vertical_square_distance = square_distance / 2
right, left, up, down = 1
horizontal_input_distance = horizontal_square_distance + right * 1
vertical_input_distance = (vertical_square_distance - (input_cell - right * 1 - last_square ** 2)).abs
result1 = horizontal_input_distance + vertical_input_distance

def next_cell(cell)
  row, col = cell
  if row >= 0 and col <= row and col.abs <= row
    [row, col + 1]
  elsif col >= 0 and col > row and row.abs < col
    [row - 1, col]
  elsif row < 0 and col > row
    [row, col - 1]
  else
    [row + 1, col]
  end
end

def neighbors(cell)
  row, col = cell
  [row - 1, row, row + 1].product([col - 1, col, col + 1])
end

def sum_of_neighbors(cell, hash)
  neighbors(cell).map { |n| hash[n] }.reduce(:+)
end

cell = [0,0]
h = Hash.new(0)
h[cell] = value = 1
while value < input_cell do
  cell = next_cell(cell)
  h[cell] = value = sum_of_neighbors(cell, h)
end

result2 = value

puts result1, result2
