input = File.read('../input/11.txt')

directions = input.split(',');
direction_frequencies = directions.group_by(&:itself).map { |k, v| [k, v.count] }.to_h

def simplify(directions, simplifiable_directions, result_vector = nil)
  min = simplifiable_directions.map { |d| directions[d] }.min
  simplifiable_directions.each { |d| directions[d] -= min }
  directions[result_vector] += min if result_vector
  directions
end

@simplifications = { ['n', 's'] => nil, ['nw', 'se'] => nil, ['ne', 'sw'] => nil, ['nw', 'ne', 's'] => nil, ['n', 'se', 'sw'] => nil,
    ['n', 'se'] => 'ne', ['ne', 's'] => 'se', ['se', 'sw'] => 's', ['nw', 's'] => 'sw', ['n', 'sw'] => 'nw', ['nw', 'ne'] => 'n' }

def simplify_all(direction_frequencies)
  @simplifications.each do |eq, v|
    simplify(direction_frequencies, eq, v)
  end
end

simplify_all(direction_frequencies)
result1 = direction_frequencies.values.reduce { |a, b| a + b }

accumulated_direction_frequencies = Hash.new(0)
max_distance = 0
directions.each do |d|
  accumulated_direction_frequencies[d] += 1
  simplify_all(accumulated_direction_frequencies)
  distance = accumulated_direction_frequencies.values.reduce { |a, b| a + b }
  max_distance = distance if distance > max_distance
end

result2 = max_distance

puts result1, result2
