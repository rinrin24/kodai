def findPrimeNumber(n)
	i = 3
	primeNumbers = []
	primeNumbers.push(2)
	loop{
		if (i == n) then; break; end;
		primeNumbers.each_index do |j|
			if((i % primeNumbers[j]) == 0) then; break; end;
			if(j == (primeNumbers.length - 1)) then; primeNumbers.push(i); break; end
		end
		i += 1
	}
	return primeNumbers
end

p(findPrimeNumber(117000))