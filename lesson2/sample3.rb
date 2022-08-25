def absoluteValue(x)
	if (x > 0) then; return x; end;
	return -x;
end
def giveErrorRange(x)
	printf("値：%5.10f, 誤差:%1.30f\n", x, absoluteValue(333 - x))
	#puts(absoluteValue(333 - x));
end
def integ2R(a, b, n)
	dx = (b - a).to_f / n
	s = 0.0
	n.times do |i|
		x = a + i * dx
		y = x**2 # 関数 f(x) の計算
		s = s + y * dx
	end
	return s
end
def integ2L(a, b, n)
	dx = (b - a).to_f / n
	s = 0.0
	n.times do |i|
		x = a + (i + 1) * dx
		y = x**2 # 関数 f(x) の計算
		s = s + y * dx
	end
	return s
end
def averageInteg2LR(a, b, n)
	return (integ2L(a, b, n) + integ2R(a, b, n)) / 2
end
def integ2M(a, b, n)
	dx = (b - a).to_f / n
	s = 0.0
	n.times do |i|
		x = a + (i + 0.5) * dx
		y = x**2 # 関数 f(x) の計算
		s = s + y * dx
	end
	return s
end
def averageInteg2All(a, b, n)
	return (averageInteg2LR(a, b, n) + integ2M(a, b, n)) / 2
end

giveErrorRange(integ2R(1.0, 10.0, 10000));
giveErrorRange(integ2L(1.0, 10.0, 10000));
giveErrorRange(averageInteg2LR(1.0, 10.0, 10000));
giveErrorRange(integ2M(1.0, 10.0, 10000));
giveErrorRange(averageInteg2All(1.0, 10.0, 10000));
