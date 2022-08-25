
def add(var1, var2)
	return var1 + var2;
end
def substract(var1, var2)
	return var1 - var2;
end
def multi(var1, var2)
	return var1 * var2;
end
def divide(var1, var2)
	return var1 / var2;
end
def remainder(var1, var2)
	return var1 % var2
end
def gyakusu(var)
	return 1.0 / var
end
def powfSix(var)
	return var * var * var * var * var * var
end
def powfSeven(var)
	return powfSix(var) * var
end
def powfEight(var)
	return powfSeven(var) * var
end
def coneVolume(radius, height)
	return Math::PI * radius * radius * height
end
def route(var)
	return Math.sqrt(var)
end


sum = add(3.0, 2.0);
subs = substract(3.0, 2.0);
mul = multi(3.0, 2.0);
div = divide(3.0, 2.0);
printf("%5e\n", sum);
printf("%5e\n", subs);
printf("%5e\n", mul);
printf("%5e\n", div);
printf("%5e\n", remainder(10.0, 3.0));
printf("%5e\n", gyakusu(5.0));
printf("%5e\n", powfSix(7.0));
printf("%5e\n", powfSeven(7.0));
printf("%5e\n", powfEight(7.0));
printf("%5e\n", coneVolume(2.0, 5.0));
printf("%5e\n", route(3));