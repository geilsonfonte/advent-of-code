input = File.read('../input/13.txt')

@layers = input.lines.map { |l| l.strip.split(': ').map { |n| n.to_i } }.to_h

def caught?(depth, range, delay = 0)
  time_at_layer = depth + delay
  trip_length = (range - 1) * 2
  time_at_layer % trip_length == 0
end

result1 = @layers.select { |depth, range| caught?(depth, range) }.map { |k, v| k * v }.reduce { |a, b| a + b }

delay = 0
while true do
  break if @layers.none? { |depth, range| caught?(depth, range, delay) }
  delay += 1
end

result2 = delay

puts result1, result2
