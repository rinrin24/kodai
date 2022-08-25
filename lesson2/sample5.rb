def gcd(x, y)
	if (x == y) then; return x; end
	if (x > y) then; return gcd(x - y, y); end
	if (x < y) then; return gcd(x, y - x); end
end

puts(gcd(20, 6));
puts(gcd(50,74));
puts(gcd(111, 259));
#二つの数の公約数をxとし、二つの数をそれぞれax, bxとする。(ax > bx)
#すると差は(a-b)xとなる。
#それと小さいほうの数(bx)を比較すると、差は|(a-2b)x|となる。
#よってこのように差と比較すると、公約数は差がその前の小さい数と同じになるまでのこる。
#そこで、差がその前の小さい数と同じになったところで、その前に二つの数を比較した方(差)はそれまでの公約数の集まりとなるため、それが最大公約数となる。
