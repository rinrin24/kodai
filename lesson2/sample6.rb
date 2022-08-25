def checkSosu(n)
	(n - 2).times do |i|
		if (n % (i + 2) == 0) then; return false; end
	end
	return true
end

puts(checkSosu(5))
