input = File.read('../input/8.txt')

h = Hash.new(0)
cs = input.strip.lines.map { |l| l.sub(/(\w+)/, 'h["\1"]').sub(' inc ', ' += ').sub(' dec ', ' -= ').sub(/if (\w+)/, 'if h["\1"]') }
cs.each { |c| eval(c) }
result1 = h.values.max

max = 0
h = Hash.new(0)
cs.each { |c|
  eval(c)
  max = h.values.max if h.values.max > max
}

result2 = max

puts result1, result2
