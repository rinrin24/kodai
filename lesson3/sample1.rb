def fizz1
	1.step(99) {|i|
		if (i % 3 == 0)
			puts("fizz")
		elsif i % 5 == 0
			puts("buzz")
		else
			puts(i)
		end
	}
end
def fizz2
	1.step(99) {|i|
		if (i % 5 == 0) then;puts("buzz"); next; end
		if (i % 3 == 0) then; puts("fizz"); next; end
		puts(i)
	}
end
def fizz3
	1.step(99) {|i|
		if (i % 15 == 0) then;puts("fizzbuzz"); next; end
		if (i % 3 == 0) then; puts("fizz"); next; end
		if (i % 5 == 0) then;puts("buzz"); next; end
		puts(i)
	}
end
def fizz4
	1.step(99) {|i|
		if (i % 2 == 0) then; next; end
		if (i % 3 == 0) then; next; end
		puts(i)
	}
end
def fizz4
	1.step(99) {|i|
		if((i % 10) == 3) then; puts("aho"); next; end
		if(((i / 10) % 10) == 3) then; puts("aho"); next; end
		if((i % 3) == 0) then; puts("aho"); next; end
		puts(i);
	}
end
fizz4;