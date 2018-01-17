input = File.read('../input/24.txt')

all_components = input.lines.map { |l| l.strip.split('/').map(&:to_i).sort }.sort

class Bridge

  attr_reader :components, :end_port, :unused

  def initialize(components, end_port, unused)
    @components = components
    @end_port = end_port
    @unused = unused
  end

  def strength
    @components.flatten.reduce(0, :+)
  end

  def children
    unused.select { |c| c.include? end_port }.map do |c|
      new_end_port = c.first == end_port ? c.last : c.first
      Bridge.new(components + [c], new_end_port, unused - [c])
    end
  end

end

bridges = []
bridges << Bridge.new([], 0, all_components)

max_strength = 0
max_length = 0
max_length_strength = 0

until bridges.empty?
  bridge = bridges.pop
  max_strength = bridge.strength if bridge.strength > max_strength
  max_length, max_length_strength = [bridge.components.size, bridge.strength] if ([bridge.components.size, bridge.strength] <=> [max_length, max_length_strength]) == 1

  bridges = bridges + bridge.children
end

result1 = max_strength
result2 = max_length_strength

puts result1, result2
