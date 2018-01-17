input = File.read('../input/7.txt')

def program(s)
  pattern = /(?<name>\w+) \((?<weight>\d+)\)( -> (?<children>[\w, ]+))?/
  match  = s.match(pattern)
  children =  match[:children] ? match[:children].split(', ') : []
  { name: match[:name], weight: match[:weight].to_i, children: children }
end

ps = input.lines.map { |l| program(l) }
cs = ps.flat_map { |p| p[:children] }.uniq
result1 = ps.select { |p| !cs.include?(p[:name]) }.first[:name]

pmap = ps.map { |p| [p[:name], p] }.to_h

def total_weight(pname, pmap)
  p = pmap[pname]
  if p[:children_weights].nil? then
    p[:children_weights] = p[:children].map { |child| total_weight(child, pmap) }
    children_total = p[:children_weights].empty? ? 0 : p[:children_weights].reduce { |a, b| a + b}
    p[:total] = p[:weight] + children_total
    p[:balanced] = p[:children_weights].uniq.size <= 1
  end
  p[:total]
end

total_weight(result1, pmap)
unbalanced_program_father = ps.reject { |p| p[:balanced] }.sort_by { |p| p[:total] }.first
target_total_weight = unbalanced_program_father[:children_weights].find { |w| unbalanced_program_father[:children_weights].count(w) > 1 }
wrong_total_weight = unbalanced_program_father[:children_weights].find { |w| w != target_total_weight }
index = unbalanced_program_father[:children_weights].index(wrong_total_weight)
unbalanced_program_name = unbalanced_program_father[:children][index]
unbalanced_program = pmap[unbalanced_program_name]
correct_weight = target_total_weight - unbalanced_program[:children_weights].reduce(:+)
result2 = correct_weight

puts result1, result2
