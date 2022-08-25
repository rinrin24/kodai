def abstract(x)
	if x > 0 then; return x; end;
	return -x
end
def bigger(a, b)
	if a > b; then; return a; end;
	return b;
end
def biggest(a, b, c)
	return bigger(bigger(a, b), c);
end
def plusMinus(x)
	if x == 0 then; return "zero"; end
	if x > 0 then; return "positive"; end
	return "negative"
end


puts abstract(-5);
puts bigger(13, 7)
puts biggest(5, 10, 4)
puts plusMinus(-5)