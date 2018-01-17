input = 301
steps = input

buffer = [0]
pos = 0
2017.times do |i|
  pos = ((pos + steps) % buffer.size) + 1
  buffer.insert(pos, i + 1)
end;

result1 = buffer[pos + 1]

pos = 0
zero_pos = 0
value_after_zero = nil
50000000.times do |i|
  n = i + 1
  pos = ((pos + steps) % n) + 1
  value_after_zero = n if pos == zero_pos + 1
  zero_pos += 1 if pos <= zero_pos
end;

result2 = value_after_zero

puts result1, result2
