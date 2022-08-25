def powf2(n)
	number = 1;
	n.times do
		number *= 2
	end
	return number
end
def kaijo(n)
	number = 1
	(n - 1).times do |i|
		number *= (n - i)
	end
	return number
end
def nConvinationR(n, r)
	return kaijo(n) / kaijo(n-r) / kaijo(r)
end
def deg2rad(x)
	return Math::PI * x / 180
end
def taylorSeriesSin(x, n)
	number = 0
	(n-1).times do |i|
		addNumber = x**(2*i+1) / kaijo(2*i+1)
		if (i % 2) == 1 then; addNumber = -addNumber; end
		#puts(addNumber)
		number += addNumber
	end
	return number
end
def taylorSeriesCos(x, n)
	number = 0
	(n-1).times do |i|
		addNumber = x**(2*i) / kaijo(2*i)
		if (i % 2) == 1 then; addNumber = -addNumber; end
		#puts(addNumber)
		number += addNumber
	end
	return number
end

puts(powf2(0));
puts(kaijo(7));
puts(nConvinationR(5, 3));
printf("%1.30f\n", taylorSeriesSin(deg2rad(30), 20));
printf("%1.30f\n", taylorSeriesCos(deg2rad(60), 20));
