def arraysum1(a)
	sum = 0
	a.each do |x| # x に配列の各要素が順次入る
		sum = sum + x
	end
	return sum
end
def arrayMax(a)
	max = 0
	a.each do |x|
		if (x > max) then; max = x; end
	end
	return max
end
def arrayMaxIndex(a)
	max = 0
	maxIndex = 0
	a.each_index do |i|
		if (a[i] > max) then; max = a[i]; maxIndex = i; end
	end
	return maxIndex
end
def arrayMaxIndexAll(a)
	max = arrayMax(a)
	maxIndex = ""
	a.each_index do |i|
		if (a[i] == max) then; maxIndex += i.to_s + " "; next; end
	end
	return maxIndex
end
def arrayLowerAverage(a)
	average = arraysum1(a).to_f / a.length
	smallNumeral = ""
	a.each do |x|
		if(x < average) then; smallNumeral += x.to_s + " "; end
	end
	return smallNumeral
end

a = [3, 10, 5, 10, 7, 9]

puts(arraysum1(a))
puts(arrayMax(a))
puts(arrayMaxIndex(a))
puts(arrayMaxIndexAll(a))
puts(arrayLowerAverage(a))