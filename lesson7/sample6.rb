def bucketsort(a)
	maxNum = maxNumber(a)
	array = Array.new(maxNum) do 1 end;
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
def maxNumber(array)
	maxNum = 0
	(array.length).times do |i|
		if(array[i] > maxNum) then; maxNum = array[i]; end
	end
	return maxNum
end
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

Element = 670000
#i = 0
#hoge = randarray(Element + i * 1000)
#p(bench do quicksort(hoge) end)
1000.times do |i|
	#t1 = Process.times.utime
	hoge = randarray(Element + i * 1000)
	#t2 = Process.times.utime
	#puts((Element + i * 1000).to_s + ", " + (t2 - t1).to_s)
	puts((Element + i*1000).to_s + ", " + (bench do bucketsort(hoge) end).to_s)
	if((Element + i*1000) == 1000000) then break end;
end