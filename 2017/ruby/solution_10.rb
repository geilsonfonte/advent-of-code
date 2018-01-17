input = File.read('../input/10.txt')

class Array
  def circular_slice(start, length)
    if start + length <= size then
      self[start, length]
    else
      self[start, size - start] + self[0, start + length - size]
    end
  end

  def circular_replace(start, length, values)
    if start + length <= size then
      self[start, length] = values
    else
      self[start, size - start] = values[0, size - start]
      self[0, start + length - size] = values[size - start, start + length - size]
    end
    self
  end

  def twist(start, length)
    circular_replace(start, length, circular_slice(start, length).reverse)
  end
end

def knot_round(input, list = (0..255).to_a, pos = 0, skip = 0)
  input.each do |length|
    list.twist(pos, length)
    pos = (pos + length + skip) % list.size
    skip += 1
  end
  [list, pos, skip]
end

def knot_hash(input)
  lengths = input.strip.chars.map(&:ord) + [17, 31, 73, 47, 23]
  list = (0..255).to_a
  pos = 0
  skip = 0
  64.times do |t|
    list, pos, skip = knot_round(lengths, list, pos, skip)
  end
  hash = []
  list.each_slice(16) { |s| hash << s.reduce(:^) }
  hash.map { |n| n.to_s(16).rjust(2, '0') }.join
end

if __FILE__ == $PROGRAM_NAME
  lengths = input.split(',').map(&:to_i)
  list = knot_round(lengths)[0]

  result1 = list[0] * list[1]

  result2 = knot_hash(input)

  puts result1, result2
end
