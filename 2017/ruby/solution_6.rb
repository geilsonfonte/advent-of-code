input = File.read('../input/6.txt')

require 'set'
m = input.split(/\s+/).map(&:to_i)
seen = Set.new
moves = 0
moves_by_state = {}

def next_state(m)
  value = m.max
  max_idx = m.index(value)
  base_inc = (value / m.size).floor
  remainder = value % m.size
  rem_start = (max_idx + 1) % m.size
  rem_end = (rem_start + remainder - 1) % m.size
  (0...(m.size)).map do |idx|
    inc = base_inc
    if idx == max_idx
      0 + inc
    else
      if rem_start <= rem_end then
        inc += 1 if idx >= rem_start and idx <= rem_end
      else
        inc += 1 if idx >= rem_start or idx <= rem_end
      end
      m[idx] + inc
    end
  end
end

until seen.include?(m)
  seen.add(m)
  moves_by_state[m] = moves
  m = next_state(m)
  moves += 1
end

result1 = moves
result2 = moves - moves_by_state[m]

puts result1, result2
