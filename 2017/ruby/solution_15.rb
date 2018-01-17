
gen_a = 722
gen_b = 354

bits = 2 ** 16

matches = 0
40000000.times do |i|
  gen_a = gen_a * 16807 % 2147483647
  gen_b = gen_b * 48271 % 2147483647

  matches += 1 if gen_a % bits == gen_b % bits
end

result1 = matches

gen_a = 722
gen_b = 354

matches = 0
5000000.times do |i|
  begin
    gen_a = gen_a * 16807 % 2147483647
  end while gen_a % 4 != 0
  begin
    gen_b = gen_b * 48271 % 2147483647
  end while gen_b % 8 != 0

  matches += 1 if gen_a % bits == gen_b % bits
end

result2 = matches

puts result1, result2
