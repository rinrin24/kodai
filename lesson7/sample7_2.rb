def randarray(n)
	return Array.new(100000) do rand(n) end
end
def bench
	t1 = Process.times.utime
	yield
	t2 = Process.times.utime
	return t2 - t1
end

def swap(a, i, j)
	tmp = a[i]
	a[i] = a[j]
	a[j] = tmp
end
def quicksort(a, i = 0, j = a.length-1)
	if j <= i
		# do nothing
	else
		pivot = a[j]; s = i
		i.step(j-1) do |k|
			if a[k] <= pivot then swap(a, s, k); s = s + 1
			end
		end
		swap(a, j, s); quicksort(a, i, s-1); quicksort(a, s+1, j)
	end
end
def maxNumber(array)
	maxNum = 0
	(array.length).times do |i|
		if(array[i] > maxNum) then; maxNum = array[i]; end
	end
	return maxNum
end
def bucketsort(a)
	maxNum = maxNumber(a)
	#p(maxNum)
	array = Array.new(maxNum+1) do 1 end;
	(a.length).times do |i|
		array[a[i]] += 1
	end
	currentindex = 0
	maxNum.times do |i|
		while array[i] > 0
			a[currentindex] = i
			array[i] -= 1
			currentindex += 1
		end
	end
end
def radixSort(array)
	outputArray = array.dup
	((Math.log2(maxNumber(array))).to_i + 1).times do |i|
		leftArray = Array.new();
		rightArray = Array.new();
		mask = 2**i
		(array.length).times do |j|
			if((outputArray[j] & mask) == 0) then
				leftArray.push(outputArray[j])
			else
				rightArray.push(outputArray[j])
			end;
		end
		leftArray.concat(rightArray)
		outputArray = leftArray
	end	
	return outputArray;	
end

Element = 2407000
RiseAmount = 1000
((10000000 - Element) / RiseAmount + 1).times do |i|
	foo = randarray(Element + i * RiseAmount)
	hoge = foo.dup
	#fuga = foo.dup
	#piyo = foo.dup
	quickSortSpeed = bench do quicksort(hoge) end
	#bucketSortSpeed = bench do bucketsort(fuga) end
	#radixSortSpeed = bench do radixSort(piyo) end
	#puts((Element + i*RiseAmount).to_s + ", " + quickSortSpeed.to_s + ", " + bucketSortSpeed.to_s + ", " + radixSortSpeed.to_s)
	puts((Element + i*RiseAmount).to_s + ", " + quickSortSpeed.to_s)
	if((Element + i*RiseAmount) == 3000000) then break end;
end