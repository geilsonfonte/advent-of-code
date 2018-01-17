input = File.read('../input/5.txt')

maze = input.strip.lines.map(&:to_i)

maze1 = maze.dup
steps = 0
idx = 0

while idx >= 0 and idx < maze1.count do
  new_idx = idx + maze1[idx]
  maze1[idx] += 1
  steps += 1
  idx = new_idx
end

result1 = steps


maze2 = maze.dup
steps = 0
idx = 0

while idx >= 0 and idx < maze2.count do
  new_idx = idx + maze2[idx]
  if maze2[idx] >= 3 then maze2[idx] -= 1 else maze2[idx] += 1 end
  steps += 1
  idx = new_idx
end

result2 = steps

puts result1, result2
