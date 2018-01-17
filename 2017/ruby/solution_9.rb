input = File.read('../input/9.txt')

clean_stream = input.gsub(/!./, '').gsub(/<.*?>/, '')
score = 0
level = 0
clean_stream.chars.each do |c|
  if c == '{' then
    level += 1
  elsif c == '}' then
    score += level
    level -= 1
  end
end
result1 = score

result2 = input.gsub(/!./, '').scan(/<(.*?)>/).join.size

puts result1, result2
