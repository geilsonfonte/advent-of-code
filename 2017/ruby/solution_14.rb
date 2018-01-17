require './solution_10'
require 'set'

input = 'jzgqcdpd'

def disk_usage(input)
  (0..127).map { |i| knot_hash("#{input}-#{i}").to_i(16).to_s(2).rjust(128, '0') }
end

disk_str = disk_usage(input)
# disk_str.each { |l| p l }
disk = disk_usage(input).map { |l| l.chars.map(&:to_i) }

result1 = disk.flatten.count(1)

def neighbors(row, col)
  result = []
  result << [row - 1, col] if row > 0
  result << [row + 1, col] if row < 127
  result << [row, col - 1] if col > 0
  result << [row, col + 1] if col < 127
  result
end

dim = (0..127).to_a
remaining_cells = dim.product(dim).select { |r, c| disk[r][c] == 1 }.to_set
visited = Set.new
regions = 0

until remaining_cells.empty?
  regions += 1
  cell = remaining_cells.first
  remaining_cells.delete(cell)
  to_visit = [cell]
  until to_visit.empty?
    # p [regions, to_visit]
    cell = to_visit.pop
    remaining_neighbors = remaining_cells.intersection neighbors(*cell)
    to_visit += remaining_neighbors.to_a
    remaining_neighbors.each { |n| remaining_cells.delete n }
  end
end

result2 = regions

puts result1, result2
