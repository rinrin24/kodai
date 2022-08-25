def absarray(a)
	b = a.dup
	b.each_index do |i|
		if b[i] < 0 then; b[i] = -b[i]; end
	end
	return b
end
def addOne(a)
	b = a.dup
	b.each_index do |i|
		b[i] += 1;
	end
	return b
end
def addOnePositive(a)
	b = a.dup
	b.each_index do |i|
		if b[i] > 0 then; b[i] += 1; end
	end
	return b
end
def swapArray(a)
	b = a.dup
	c = a.dup
	(b.length / 2).times do |i|
		c[i + b.length / 2] = b[i]
	end
	(b.length / 2).times do |i|
		c[i] = b[i + b.length / 2]
	end
	return c
end

A = [-1, 5, -4, 3, -9, 7]
p(absarray(A))
p(addOne(A))
p(addOnePositive(A))
p(swapArray(A))