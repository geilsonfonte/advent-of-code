input = File.read('../input/4.txt')

ls = input.lines.map { |l| l.split }
result1 = ls.select { |l| l.uniq.size == l.size }.count

ols = ls.map { |l| l.map { |w| w.chars.sort.join } }
result2 = ols.select { |l| l.uniq.size == l.size }.count

puts result1, result2
