input = File.read('../input/1.txt')

ds = input.strip.chars.map(&:to_i)

result1 = (ds + [ds.first]).each_cons(2).select { |p| p.first == p.last}.map(&:first).reduce(:+)

def halfway_around(list, idx)
  (idx + (list.size / 2)) % list.size
end

result2 = ds.each_with_index.select { |n, idx| n == ds[halfway_around(ds, idx)] }.map(&:first).reduce(:+)

puts result1, result2
