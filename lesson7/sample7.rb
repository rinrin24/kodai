def randarray(n)
	return Array.new(n) do rand(10000) end
end
def bench
	t1 = Process.times.utime
	yield
	t2 = Process.times.utime
	return t2 - t1
end
def issorted(a)
	(a.length-1).times do |i|
		if(a[i] > a[i+1]) then; return false; end;
	end
	return true
end

def maxNumber(array)
	maxNum = 0
	(array.length).times do |i|
		if(array[i] > maxNum) then; maxNum = array[i]; end
	end
	return maxNum
end
def radixSort(array)
	outputArray = array.dup
	((Math.log2(maxNumber(array))).to_i + 1).times do |i|
	#100.times do |i|
		leftArray = Array.new();
		rightArray = Array.new();
		mask = 2**i
		#p(mask)
		(array.length).times do |j|
			if((outputArray[j] & mask) == 0) then
				leftArray.push(outputArray[j])
			else
				rightArray.push(outputArray[j])
			end;
		end
		#p(leftArray)
		#p(rightArray)
		leftArray.concat(rightArray)
		outputArray = leftArray
		#p(outputArray)
		#break;
	end	
	return outputArray;	
end

#hoge = randarray(10000)
#p(hoge)
#hoge = radixSort(hoge)
#p(hoge)
#p(issorted(hoge))

Element = 542000
((1000000 - Element) / 1000 + 1).times do |i|
	hoge = randarray(Element + i * 1000)
	puts((Element + i*1000).to_s + ", " + (bench do radixSort(hoge) end).to_s)
	if((Element + i*1000) == 1000000) then break end;
end