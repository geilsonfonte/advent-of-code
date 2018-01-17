input = File.read('../input/2.txt')

cs = input.lines.map { |l| l.split.map(&:to_i).sort }

result1 = cs.map { |xs| xs.last - xs.first }.reduce(:+)

def checksum2(arr)
  c = arr.combination(2).find { |c| c.last % c.first == 0 }
  c.last / c.first
end

result2 = cs.map { |ls| checksum2(ls) }.reduce(:+)

puts result1, result2
