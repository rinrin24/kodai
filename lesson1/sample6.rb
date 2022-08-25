def substract(a, b)
	printf("%.20g\n", a - b);
end
def add(a, b)
	printf("%.20g\n", a + b);
end
def multiple(a, b)
	printf("%.20g\n", a * b);
end
def divide(a, b)
	printf("%.20g\n", a / b);
end

substract(1.12345, 1.0);
substract(1.1234512345, 1.12345);
substract(1.1234512345, 1.123451234);

add(1.0, 0.0012345);
add(1.0, 0.00000000012345);
add(1.0, 0.000000000000012345);
add(1.0, 0.0000000000000012345);

multiple(1.0, 0.1);
divide(1.0, 10);
multiple(1.3, 0.125);
divide(1.3, 8.0);
