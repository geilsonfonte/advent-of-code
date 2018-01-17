#TODO parse input file for instructions
#input = File.read('../input/25.txt')

require 'set'

LEFT = -1
RIGHT = 1

blueprints = {
  'A' => { false => [true, RIGHT, 'B'], true => [false, LEFT, 'C'] },
  'B' => { false => [true, LEFT, 'A'], true => [true, LEFT, 'D'] },
  'C' => { false => [true, RIGHT, 'D'], true => [false, RIGHT, 'C'] },
  'D' => { false => [false, LEFT, 'B'], true => [false, RIGHT, 'E'] },
  'E' => { false => [true, RIGHT, 'C'], true => [true, LEFT, 'F'] },
  'F' => { false => [true, LEFT, 'E'], true => [true, RIGHT, 'A'] },
}

tape = Set.new
current_slot = 0
current_state = 'A'

12172063.times do |i|
  is_lit = tape.include? current_slot
  turn_slot_on, direction, next_state = blueprints[current_state][is_lit]
  if turn_slot_on
    tape.add current_slot
  else
    tape.delete current_slot
  end
  current_slot = current_slot + direction
  current_state = next_state
end

checksum = tape.count
result1 = checksum

puts result1
