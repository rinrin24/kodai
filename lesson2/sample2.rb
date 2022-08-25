def countdown(n)
	while n > 0 do
		puts(n)
		n = n - 1
		sleep(1)
	end
end
def countup(n)
	i = 0;
	while i <= n
		puts(i)
		i += 1
		sleep(1)
	end
end
def bekiup(n)
	i = 0
	while 2**i < n
		puts(2**i)
		i += 1
		sleep(1)
	end
end
def deg2rad(x)
	return Math::PI * x / 180
end
def countSin()
	i = 0
	while i <= 90
		printf("sin(%g°) = %g\n", i, Math.sin(deg2rad(i)))
		i += 15
		sleep(1)
	end
end

#countdown(10);
#countup(5);
#bekiup(20)
countSin()