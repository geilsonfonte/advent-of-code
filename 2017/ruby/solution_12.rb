require 'set'

input = File.read('../input/12.txt')

edges = input.lines.map do |l|
  captures = /(\d+)\D+([\d ,]+)/.match(l).captures
  [captures.first.to_i, captures.last.split(', ').map(&:to_i)]
end.to_h;

def group(start, edges)
  visited = Set.new
  queue = [start]

  while not queue.empty?
    n = queue.pop
    visited.add(n)
    edges[n].each do |e|
      queue.push(e) unless visited.include?(e)
    end
  end
  visited
end

result1 = group(0, edges).size

visited = Set.new
group_count = 0
edges.keys.each do |n|
  if not visited.include?(n)
    visited.merge(group(n, edges))
    group_count += 1
  end
end

result2 = group_count

puts result1, result2
